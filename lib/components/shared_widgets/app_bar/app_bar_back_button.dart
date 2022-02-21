import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';

enum BackButtonSize { small, big }

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    required this.onPressed,
    this.color = AppColors.purple,
    this.size = BackButtonSize.small,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final BackButtonSize size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: color,
        fixedSize: _calculateSize(),
        minimumSize: _calculateSize(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_calculateBorderRadius()),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: color.withOpacity(0.1),
      ),
      child: SvgPicture.asset(
        AppResources.arrowBack,
        width: _calculateIconSize(),
        matchTextDirection: true,
        color: color,
      ),
    );
  }

  Size _calculateSize() {
    switch (size) {
      case BackButtonSize.small:
        return const Size(40.0, 40.0);
      case BackButtonSize.big:
        return const Size(48.0, 48.0);
    }
  }

  double _calculateBorderRadius() {
    switch (size) {
      case BackButtonSize.small:
        return 12.0;
      case BackButtonSize.big:
        return 15.0;
    }
  }

  double _calculateIconSize() {
    switch (size) {
      case BackButtonSize.small:
        return 17.0;
      case BackButtonSize.big:
        return 21.0;
    }
  }
}
