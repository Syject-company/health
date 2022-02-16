import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/dialogs/dialog.dart';
import 'package:health_plus/components/shared_widgets/app_bar/app_bar_back_button.dart';
import 'package:health_plus/components/shared_widgets/health_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/components/shared_widgets/health_outlined_button.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/elevation.dart';

import 'bloc/registration_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) async {
        if (state.status == RegistrationStatus.error) {
          showHealthDialog(
            context,
            type: DialogType.error,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == RegistrationStatus.registered) {
          await showHealthDialog(
            context,
            type: DialogType.success,
            contentText: 'text.successful_registration'.tr(),
            actionText: 'button.close'.tr(),
          );
          rootNavigator.pop();
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

  Widget _buildRegistrationForm() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
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
              HealthInput(
                labelText: 'input.full_name'.tr(),
                keyboardType: TextInputType.text,
                onChanged: context.registrationBloc.setFullName,
                readOnly: state.status == RegistrationStatus.processing,
              ),
              const SizedBox(height: 28.0),
              HealthInput(
                labelText: 'input.email'.tr(),
                keyboardType: TextInputType.emailAddress,
                onChanged: context.registrationBloc.setEmail,
                readOnly: state.status == RegistrationStatus.processing,
              ),
              const SizedBox(height: 28.0),
              HealthInput(
                labelText: 'input.password'.tr(),
                keyboardType: TextInputType.visiblePassword,
                onChanged: context.registrationBloc.setPassword,
                readOnly: state.status == RegistrationStatus.processing,
              ),
              const SizedBox(height: 20.0),
              _buildRegisterButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRegisterButton(
    BuildContext context,
    RegistrationState state,
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
            context.registrationBloc.register();
          },
          isLoading: state.status == RegistrationStatus.processing,
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
      onPressed: rootNavigator.pop,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'button.have_account'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 20.0),
          Text(
            'button.login'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
