import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/shared_widgets/app_bar/app_bar_back_button.dart';
import 'package:health_plus/components/shared_widgets/health_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_outlined_button.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/elevation.dart';

import 'widgets/otp_code_input.dart';

const String _otpFormInputPrefix = 'otpFormInput';

class CodeConfirmationScreen extends StatelessWidget {
  CodeConfirmationScreen({Key? key}) : super(key: key);

  final GlobalKey<OtpCodeInputState> _otpCodeInputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SizedBox.expand(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
            child: Column(
              children: [
                _buildLogo(),
                const SizedBox(height: 48.0),
                _buildRegistrationForm(),
                const SizedBox(height: 32.0),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: 20.0,
          start: 16.0,
          child: AppBarBackButton(
            onPressed: () {
              rootNavigator.pop();
            },
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

  Widget _buildRegistrationForm() {
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
            'Enter the code',
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
            'A four-character code has been sent to enable you to recover your account',
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
          OtpCodeInput(
            key: _otpCodeInputKey,
            inputPrefix: _otpFormInputPrefix,
            length: 4,
          ),
          const SizedBox(height: 32.0),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Elevation(
        color: AppColors.purple.withOpacity(0.3),
        offset: const Offset(0.0, 10.0),
        blurRadius: 30.0,
        child: HealthIconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SvgPicture.asset(
            AppResources.arrowNext,
            matchTextDirection: true,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return HealthOutlinedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            '0:45',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: 20.0),
          Text(
            'Resend',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
