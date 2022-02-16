import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_plus/components/shared_widgets/health_step_indicator.dart';
import 'package:health_plus/extensions/sizer.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/utils/disallow_glow.dart';

const PageScrollPhysics _pageScrollPhysics = PageScrollPhysics();

class Banners extends StatefulWidget {
  const Banners({
    Key? key,
    required this.options,
    required this.items,
  }) : super(key: key);

  final BannersOptions options;
  final List<Widget> items;

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  late final PageController _pageController = PageController(
    viewportFraction: widget.options.viewportFraction,
    initialPage: _lastReportedPage,
  );

  int _lastReportedPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.options.autoPlay) {
      _startAutoPlayCarousel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.options.height ?? _calculateHeight();
    final axisDirection = _getDirection();
    final physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.options.allowImplicitScrolling,
    ).applyTo(widget.options.pageSnapping ? _pageScrollPhysics : null);

    return Column(
      children: [
        SizedBox(
          height: height,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.depth == 0 &&
                  notification is ScrollUpdateNotification) {
                final metrics = notification.metrics as PageMetrics;
                final currentPage = metrics.page!.round();
                if (currentPage != _lastReportedPage) {
                  setState(() => _lastReportedPage = currentPage);
                }
              }
              return false;
            },
            child: DisallowGlow(
              child: Scrollable(
                dragStartBehavior: DragStartBehavior.start,
                axisDirection: axisDirection,
                controller: _pageController,
                physics: physics,
                viewportBuilder: (_, position) {
                  return Viewport(
                    cacheExtent:
                        widget.options.allowImplicitScrolling ? 1.0 : 0.0,
                    cacheExtentStyle: CacheExtentStyle.viewport,
                    axisDirection: axisDirection,
                    clipBehavior: Clip.none,
                    offset: position,
                    slivers: [
                      SliverFillViewport(
                        viewportFraction: _pageController.viewportFraction,
                        delegate: SliverChildBuilderDelegate(
                          (_, index) {
                            return _wrapItem(widget.items.asMap()[index]);
                          },
                          childCount: widget.items.length,
                        ),
                        padEnds: false,
                      ),
                    ],
                  );
                },
              ),
            ),
          ), // child: PageView.builder(
        ),
        const SizedBox(height: 24.0),
        HealthStepIndicator(
          stepsAmount: widget.items.length,
          step: _lastReportedPage,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _wrapItem(Widget? item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.options.borderRadius),
      child: item ?? const SizedBox.shrink(),
    ).withPaddingSymmetric(widget.options.spaceBetween / 2.0, 0.0);
  }

  AxisDirection _getDirection() {
    final textDirection = Directionality.of(context);
    return textDirectionToAxisDirection(textDirection);
  }

  double _calculateHeight() {
    return ((100.w / widget.options.aspectRatio) *
            widget.options.viewportFraction) -
        (widget.options.spaceBetween / 2.0);
  }

  void _startAutoPlayCarousel() {
    _timer ??= Timer.periodic(
      widget.options.autoPlayInterval,
      (_) {
        if ((_pageController.page! / widget.options.viewportFraction).floor() ==
            widget.items.length - 1) {
          _pageController.animateToPage(
            0,
            duration: widget.options.autoPlayAnimationDuration,
            curve: widget.options.autoPlayCurve,
          );
        } else {
          _pageController.nextPage(
            duration: widget.options.autoPlayAnimationDuration,
            curve: widget.options.autoPlayCurve,
          );
        }
      },
    );
  }
}

class BannersOptions {
  BannersOptions({
    this.height,
    this.spaceBetween = 32.0,
    this.borderRadius = 21.0,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 1.0,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 750),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.allowImplicitScrolling = false,
    this.pageSnapping = true,
  });

  final double? height;
  final double spaceBetween;
  final double borderRadius;
  final double aspectRatio;
  final double viewportFraction;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final bool allowImplicitScrolling;
  final bool pageSnapping;
}

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    required this.allowImplicitScrolling,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}
