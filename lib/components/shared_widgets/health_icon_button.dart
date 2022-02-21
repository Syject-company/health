import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

class HealthIconButton extends StatelessWidget {
  const HealthIconButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width = 64.0,
    this.height = 64.0,
    this.borderRadius = 15.0,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isLoading ? onPressed : null,
      style: TextButton.styleFrom(
        primary: AppColors.white,
        backgroundColor: AppColors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        fixedSize: Size(width, height),
        minimumSize: Size(width, height),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: !isLoading ? child : _buildLoadingIndicator(),
    );
  }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator(color: AppColors.white);
  }
}
