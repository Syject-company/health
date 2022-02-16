import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

class HealthHospitalIcon extends StatelessWidget {
  const HealthHospitalIcon({
    Key? key,
    required this.imageUrl,
    this.borderWidth = 3.0,
    this.borderRadius = 14.0,
  }) : super(key: key);

  final String imageUrl;
  final double borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 2.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
