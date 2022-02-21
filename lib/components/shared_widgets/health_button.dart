import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

class HealthButton extends StatelessWidget {
  const HealthButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.isLoading = false,
    this.expanded = false,
    this.height = 56.0,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final bool isLoading;
  final bool expanded;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isLoading ? onPressed : null,
      style: TextButton.styleFrom(
        primary: AppColors.white,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        minimumSize: Size(expanded ? double.infinity : 0.0, height),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: !isLoading ? child : _buildLoadingIndicator(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator(color: AppColors.white);
  }
}
