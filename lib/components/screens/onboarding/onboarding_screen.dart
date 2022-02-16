import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/screens/onboarding/widgets/next_button.dart';
import 'package:health_plus/components/shared_widgets/separated_row.dart';
import 'package:health_plus/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'bloc/onboarding_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (_, state) {
        if (state.status == OnboardingStatus.finished) {
          rootNavigator.pushReplacementNamed(RootRoutes.login);
        }
      },
      child: SizedBox.expand(
        child: Center(
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              final stepData = stepsData[state.step];

              return SingleChildScrollView(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    _buildImage(stepData.imagePath),
                    const SizedBox(height: 48.0),
                    _StepIndicator(
                      stepsAmount: stepsData.length,
                      step: state.step,
                    ),
                    const SizedBox(height: 48.0),
                    _buildTitle(stepData.title),
                    const SizedBox(height: 8.0),
                    _buildSubtitle(),
                    const SizedBox(height: 48.0),
                    const NextButton(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Image.asset(imagePath),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title.tr(),
      style: const TextStyle(
        height: 1.33,
        fontSize: 24.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'text.onboarding_subtitle'.tr(),
      style: const TextStyle(
        height: 1.57,
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
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
