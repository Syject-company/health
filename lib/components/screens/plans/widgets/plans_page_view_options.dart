part of 'plans_page_view.dart';

class PlansPageViewOptions {
  PlansPageViewOptions({
    this.onPageChanged,
    this.spaceBetween = 0.0,
    this.borderRadius = 0.0,
    this.viewportFraction = 1.0,
    this.allowImplicitScrolling = false,
    this.pageSnapping = true,
    this.alignCenter = true,
    this.reverse = false,
  });

  final Function(int index)? onPageChanged;
  final double spaceBetween;
  final double borderRadius;
  final double viewportFraction;
  final bool allowImplicitScrolling;
  final bool pageSnapping;
  final bool alignCenter;
  final bool reverse;
}
