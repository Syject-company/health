import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/onboarding/bloc/onboarding_bloc.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.0,
      height: 75.0,
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8BD3E6)),
        shape: BoxShape.circle,
      ),
      child: TextButton(
        onPressed: context.onboardingBloc.jumpNextStep,
        style: TextButton.styleFrom(
          primary: AppColors.white,
          backgroundColor: const Color(0xFF7D55C7),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
        ),
        child: SvgPicture.asset(
          AppResources.arrowNext,
          matchTextDirection: true,
        ),
      ),
    );
  }
}
