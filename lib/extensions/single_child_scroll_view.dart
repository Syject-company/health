import 'package:flutter/widgets.dart';

extension SingleChildScrollViewExtension on SingleChildScrollView {
  void scrollToWidget(
    BuildContext context,
    BuildContext childContext, {
    bool animate = true,
  }) {
    final renderBox = context.findRenderObject() as RenderBox?;
    final childRenderBox = childContext.findRenderObject() as RenderBox?;

    final textDirection = Directionality.of(context);
    final padding = this.padding?.resolve(textDirection) ?? EdgeInsets.zero;
    final controller = this.controller;

    if (controller != null && renderBox != null && childRenderBox != null) {
      final childSize = childRenderBox.size;
      final scrollOffset = controller.offset;
      final viewport = controller.position.viewportDimension;

      final globalPosition = renderBox.localToGlobal(Offset.zero);
      final localChildPosition = -childRenderBox.globalToLocal(globalPosition);

      switch (scrollDirection) {
        case Axis.horizontal:
          if (localChildPosition.dx < padding.left) {
            _moveTo(
              (scrollOffset + localChildPosition.dx) - padding.left,
              animate,
            );
          } else if ((localChildPosition.dx + childSize.width) >
              (viewport - padding.right)) {
            _moveTo(
              (scrollOffset + localChildPosition.dx + childSize.width) -
                  (viewport - padding.right),
              animate,
            );
          }
          break;
        case Axis.vertical:
          if (localChildPosition.dy < padding.top) {
            _moveTo(
              (scrollOffset + localChildPosition.dy) - padding.top,
              animate,
            );
          } else if ((localChildPosition.dy + childSize.height) >
              (viewport - padding.bottom)) {
            _moveTo(
              (scrollOffset + localChildPosition.dy + childSize.height) -
                  (viewport - padding.bottom),
              animate,
            );
          }
          break;
      }
    }
  }

  void _moveTo(double position, bool animate) {
    animate
        ? controller?.animateTo(
            position,
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
          )
        : controller?.jumpTo(position);
  }
}
