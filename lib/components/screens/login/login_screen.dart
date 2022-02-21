import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/dialogs/dialog.dart';
import 'package:health_plus/components/screens/login/bloc/login_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_button.dart';
import 'package:health_plus/components/shared_widgets/health_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/components/shared_widgets/health_outlined_button.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/elevation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          showHealthDialog(
            context,
            type: DialogType.error,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == LoginStatus.warning) {
          showHealthDialog(
            context,
            type: DialogType.warning,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == LoginStatus.logged) {
          rootNavigator.pushReplacementNamed(RootRoutes.home);
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
              body: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
        child: Column(
          children: [
            _buildLogo(),
            const SizedBox(height: 48.0),
            _buildEmailForm(),
            const SizedBox(height: 32.0),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(AppResources.logoWithLabelWhite);
  }

  Widget _buildEmailForm() {
    return BlocBuilder<LoginBloc, LoginState>(
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
                labelText: 'input.email'.tr(),
                keyboardType: TextInputType.emailAddress,
                onChanged: context.loginBloc.setEmail,
                readOnly: state.status == LoginStatus.processing,
              ),
              const SizedBox(height: 28.0),
              HealthInput(
                labelText: 'input.password'.tr(),
                keyboardType: TextInputType.visiblePassword,
                onChanged: context.loginBloc.setPassword,
                readOnly: state.status == LoginStatus.processing,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRememberPasswordButton(),
                  _buildLoginButton(context, state),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildRememberPasswordButton() {
    return GestureDetector(
      onTap: () {
        rootNavigator.pushNamed(RootRoutes.resetPassword);
      },
      child: Text(
        'text.forgot_your_password'.tr(),
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w400,
          color: AppColors.purple,
        ),
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    LoginState state,
  ) {
    return Elevation(
      color: AppColors.purple.withOpacity(0.3),
      offset: const Offset(0.0, 10.0),
      blurRadius: 30.0,
      child: HealthIconButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.loginBloc.login();
        },
        isLoading: state.status == LoginStatus.processing,
        child: SvgPicture.asset(
          AppResources.arrowNext,
          matchTextDirection: true,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: HealthButton(
            onPressed: () {
              rootNavigator.pushNamed(RootRoutes.registration);
            },
            backgroundColor: AppColors.lightBlue,
            child: Text(
              'button.create_new_account'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: HealthOutlinedButton(
            onPressed: () {
              rootNavigator.pushReplacementNamed(RootRoutes.home);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'button.browse_app'.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 5.0),
                SvgPicture.asset(
                  AppResources.arrowNext,
                  matchTextDirection: true,
                  width: 12.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
