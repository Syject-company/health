import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/dialogs/dialog.dart';
import 'package:health_plus/components/screens/change_password/bloc/change_password_bloc.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/health_flat_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/router.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) async {
        if (state.status == ChangePasswordStatus.error) {
          showHealthDialog(
            context,
            type: DialogType.error,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == ChangePasswordStatus.changed) {
          await showHealthDialog(
            context,
            type: DialogType.success,
            contentText: 'text.successful_password_change'.tr(),
            actionText: 'button.close'.tr(),
          );
          rootNavigator.pop();
        }
      },
      child: Container(
        color: AppColors.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: HealthAppBar(backNavigation: true),
              body: _buildBody(),
              bottomNavigationBar: _saveChangesButton(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.only(
          start: 16.0,
          top: 8.0,
          bottom: 16.0,
          end: 16.0,
        ),
        child: Column(
          children: [
            _buildTitle(),
            const SizedBox(height: 48.0),
            _buildChangePasswordForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'text.change_password'.tr(),
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.purpleDarkGrey,
        ),
      ),
    );
  }

  Widget _buildChangePasswordForm() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HealthInput(
              labelText: 'input.old_password'.tr(),
              keyboardType: TextInputType.visiblePassword,
              onChanged: context.changePasswordBloc.setOldPassword,
              readOnly: state.status == ChangePasswordStatus.processing,
            ),
            const SizedBox(height: 24.0),
            HealthInput(
              labelText: 'input.new_password'.tr(),
              keyboardType: TextInputType.visiblePassword,
              onChanged: context.changePasswordBloc.setNewPassword,
              readOnly: state.status == ChangePasswordStatus.processing,
            ),
            const SizedBox(height: 24.0),
            HealthInput(
              labelText: 'input.confirm_password'.tr(),
              keyboardType: TextInputType.visiblePassword,
              onChanged: context.changePasswordBloc.setConfirmPassword,
              readOnly: state.status == ChangePasswordStatus.processing,
            ),
          ],
        );
      },
    );
  }

  Widget _saveChangesButton() {
    return BlocSelector<ChangePasswordBloc, ChangePasswordState,
        ChangePasswordStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return HealthFlatButton(
          onPressed: context.changePasswordBloc.saveChanges,
          isLoading: status == ChangePasswordStatus.processing,
          text: 'button.save'.tr(),
        );
      },
    );
  }
}
