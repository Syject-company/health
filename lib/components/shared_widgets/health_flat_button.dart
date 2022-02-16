import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

class HealthFlatButton extends StatelessWidget {
  const HealthFlatButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.foregroundColor = AppColors.white,
    this.backgroundColor = AppColors.purple,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isLoading ? onPressed : null,
      style: TextButton.styleFrom(
        primary: foregroundColor,
        backgroundColor: backgroundColor,
        fixedSize: const Size.fromHeight(56.0),
        maximumSize: const Size.fromHeight(56.0),
        minimumSize: const Size.fromHeight(56.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(),
      ),
      child: !isLoading
          ? Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
                color: foregroundColor,
              ),
            )
          : _buildLoadingIndicator(),
    );
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator(
      color: foregroundColor,
    );
  }
}
