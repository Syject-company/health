import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/dialogs/dialog.dart';
import 'package:health_plus/components/shared_widgets/app_bar/app_bar_back_button.dart';
import 'package:health_plus/components/shared_widgets/health_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/elevation.dart';

import 'bloc/reset_password_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == ResetPasswordStatus.error) {
          showHealthDialog(
            context,
            type: DialogType.error,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: AppColors.scaffoldGradient,
          ),
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.transparent,
              extendBodyBehindAppBar: true,
              body: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SizedBox.expand(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 48.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              children: [
                _buildLogo(),
                const SizedBox(height: 48.0),
                _buildResetPasswordForm(),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: 20.0,
          start: 16.0,
          child: AppBarBackButton(
            onPressed: rootNavigator.pop,
            color: AppColors.white,
            size: BackButtonSize.big,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(AppResources.logoWithLabelWhite);
  }

  Widget _buildResetPasswordForm() {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 40.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              const Text(
                'Forgot your password?',
                style: TextStyle(
                  height: 1.33,
                  fontSize: 24.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Please enter the email you have registered with our platform to be able to retrieve your password',
                style: TextStyle(
                  height: 1.57,
                  fontSize: 14.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28.0),
              HealthInput(
                labelText: 'input.email'.tr(),
                keyboardType: TextInputType.emailAddress,
                onChanged: context.resetPasswordBloc.setEmail,
                readOnly: state.status == ResetPasswordStatus.processing,
              ),
              const SizedBox(height: 20.0),
              _buildResetPasswordButton(context, state)
            ],
          ),
        );
      },
    );
  }

  Widget _buildResetPasswordButton(
    BuildContext context,
    ResetPasswordState state,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Elevation(
        color: AppColors.purple.withOpacity(0.3),
        offset: const Offset(0.0, 10.0),
        blurRadius: 30.0,
        child: HealthIconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.resetPasswordBloc.reset();
          },
          isLoading: state.status == ResetPasswordStatus.processing,
          child: SvgPicture.asset(
            AppResources.arrowNext,
            matchTextDirection: true,
          ),
        ),
      ),
    );
  }
}
