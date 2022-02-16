import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

class HealthFlatIconButton extends StatelessWidget {
  const HealthFlatIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.foregroundColor = AppColors.white,
    this.backgroundColor = AppColors.purple,
    this.isLoading = false,
    this.expanded = false,
    this.height = 56.0,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool isLoading;
  final bool expanded;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isLoading ? onPressed : null,
      style: TextButton.styleFrom(
        primary: foregroundColor,
        backgroundColor: backgroundColor,
        minimumSize: Size(expanded ? double.infinity : 0.0, height),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(),
      ),
      child: !isLoading ? icon : _buildLoadingIndicator(),
    );
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator(
      color: foregroundColor,
    );
  }
}
