import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

class QrCodeCard extends StatelessWidget {
  const QrCodeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.scaffoldGradient,
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
        ),
        borderRadius: BorderRadius.circular(19.0),
      ),
      child: Row(
        children: [
          DottedBorder(
            strokeWidth: 2.0,
            dashPattern: const [8.0, 8.0],
            borderType: BorderType.RRect,
            radius: const Radius.circular(11.0),
            color: AppColors.white,
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 62.0,
              height: 62.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Name of Hospital',
                style: TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'Last update: time and date',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
