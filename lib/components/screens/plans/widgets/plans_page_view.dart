import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_plus/extensions/widget.dart';

part 'plans_page_view_options.dart';

const PageScrollPhysics _pageScrollPhysics = PageScrollPhysics();

class PlansPageView extends StatefulWidget {
  const PlansPageView({
    Key? key,
    required this.options,
    required this.items,
  }) : super(key: key);

  final PlansPageViewOptions options;
  final List<Widget> items;

  @override
  _PlansPageViewState createState() => _PlansPageViewState();
}

class _PlansPageViewState extends State<PlansPageView> {
  late PageController _pageController;
  late int _lastReportedPage;

  @override
  Widget build(BuildContext context) {
    _lastReportedPage = 0;
    _pageController = PageController(
      viewportFraction: widget.options.viewportFraction,
      initialPage: _lastReportedPage,
    );

    final axisDirection = _getDirection(context);
    final physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.options.allowImplicitScrolling,
    ).applyTo(widget.options.pageSnapping ? _pageScrollPhysics : null);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.depth == 0 &&
            widget.options.onPageChanged != null &&
            notification is ScrollUpdateNotification) {
          final metrics = notification.metrics as PageMetrics;
          final currentPage = metrics.page!.round();
          if (currentPage != _lastReportedPage) {
            widget.options.onPageChanged!(currentPage);
            _lastReportedPage = currentPage;
          }
        }
        return false;
      },
      child: Scrollable(
        dragStartBehavior: DragStartBehavior.start,
        axisDirection: axisDirection,
        controller: _pageController,
        physics: physics,
        viewportBuilder: (_, position) {
          return Viewport(
            cacheExtent: widget.options.allowImplicitScrolling ? 1.0 : 0.0,
            cacheExtentStyle: CacheExtentStyle.viewport,
            axisDirection: axisDirection,
            clipBehavior: Clip.none,
            offset: position,
            slivers: [
              SliverFillViewport(
                viewportFraction: _pageController.viewportFraction,
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return widget.items.isNotEmpty
                        ? _wrapItem(
                            widget.items.asMap()[index % widget.items.length],
                          )
                        : const SizedBox.shrink();
                  },
                  childCount: widget.items.length,
                ),
                padEnds: widget.options.alignCenter,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _wrapItem(Widget? item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.options.borderRadius),
      child: item ?? const SizedBox.shrink(),
    ).withPaddingSymmetric(widget.options.spaceBetween / 2.0, 0.0);
  }

  AxisDirection _getDirection(BuildContext context) {
    final textDirection = Directionality.of(context);
    final axisDirection = textDirectionToAxisDirection(textDirection);
    return widget.options.reverse
        ? flipAxisDirection(axisDirection)
        : axisDirection;
  }
}

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    ScrollPhysics? parent,
    required this.allowImplicitScrolling,
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
