import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';

import 'separated_row.dart';

class HealthStepIndicator extends StatelessWidget {
  const HealthStepIndicator({
    Key? key,
    required this.stepsAmount,
    required this.step,
  }) : super(key: key);

  final int stepsAmount;
  final int step;

  @override
  Widget build(BuildContext context) {
    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.center,
      separator: const SizedBox(width: 8.0),
      children: [
        for (int i = 0; i < stepsAmount; i++) _buildIndicator(i == step),
      ],
    );
  }

  Widget _buildIndicator(bool selected) {
    return Container(
      width: 24.0,
      height: 6.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: selected ? AppColors.purple : AppColors.purpleLight,
      ),
    );
  }
}
