import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/dialogs/dialog.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/health_flat_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/utils/masked_input_controller.dart';

import 'bloc/support_bloc.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneNumberController = MaskedInputController(
    filter: {'#': RegExp(r'[0-9]')},
    mask: '############',
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupportBloc, SupportState>(
      listener: (context, state) {
        if (state.status == SupportStatus.error) {
          showHealthDialog(
            context,
            type: DialogType.error,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == SupportStatus.warning) {
          showHealthDialog(
            context,
            type: DialogType.warning,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == SupportStatus.sent) {
          showHealthDialog(
            context,
            type: DialogType.success,
            contentText: 'text.successful_message_send'.tr(),
            actionText: 'button.close'.tr(),
          );
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
              bottomNavigationBar: _buildSaveButton(context),
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
            _buildProfileForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'text.connect_with_support'.tr(),
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.purpleDarkGrey,
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    return BlocBuilder<SupportBloc, SupportState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HealthInput(
              initialValue: state.fullName,
              labelText: 'input.full_name'.tr(),
              keyboardType: TextInputType.text,
              onChanged: context.supportBloc.setFullName,
            ),
            const SizedBox(height: 24.0),
            HealthInput(
              initialValue: state.phoneNumber,
              controller: _phoneNumberController,
              labelText: 'input.phone_number'.tr(),
              keyboardType: TextInputType.phone,
              onChanged: context.supportBloc.setPhoneNumber,
            ),
            /*  const SizedBox(height: 24.0),
            HealthInput(
              initialValue: state.email,
              labelText: 'input.email'.tr(),
              keyboardType: TextInputType.emailAddress,
              onChanged: context.supportBloc.setEmail,
            ), */
            const SizedBox(height: 24.0),
            HealthInput(
              labelText: 'input.ticket_subject'.tr(),
              keyboardType: TextInputType.text,
              onChanged: context.supportBloc.setSubject,
            ),
            const SizedBox(height: 24.0),
            HealthInput(
              labelText: 'input.ticket_description'.tr(),
              keyboardType: TextInputType.multiline,
              onChanged: context.supportBloc.setDescription,
              minLines: 6,
              maxLines: 6,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocSelector<SupportBloc, SupportState, SupportStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return HealthFlatButton(
          onPressed: context.supportBloc.send,
          isLoading: status == SupportStatus.processing,
          text: 'button.send'.tr(),
        );
      },
    );
  }
}
