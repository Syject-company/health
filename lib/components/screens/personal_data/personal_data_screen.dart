import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/dialogs/dialog.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/health_flat_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/utils/masked_input_controller.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/personal_data_bloc.dart';

class PersonalDataScreen extends StatelessWidget {
  PersonalDataScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneNumberController = MaskedInputController(
    filter: {'#': RegExp(r'[0-9]')},
    mask: '############',
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalDataBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showHealthDialog(
            context,
            type: DialogType.error,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == ProfileStatus.warning) {
          showHealthDialog(
            context,
            type: DialogType.warning,
            contentText: state.error ?? '',
            actionText: 'button.close'.tr(),
          );
        } else if (state.status == ProfileStatus.saved) {
          showHealthDialog(
            context,
            type: DialogType.success,
            contentText: 'text.successful_profile_save'.tr(),
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
              bottomNavigationBar: _buildSaveButton(),
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
        'text.personal_data'.tr(),
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
    return BlocBuilder<PersonalDataBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatarPicker(context, state),
            const SizedBox(height: 32.0),
            HealthInput(
              initialValue: state.fullName,
              labelText: 'input.full_name'.tr(),
              keyboardType: TextInputType.text,
              onChanged: context.personalDataBloc.setFullName,
            ),
            const SizedBox(height: 24.0),
            HealthInput(
              initialValue: state.phoneNumber,
              controller: _phoneNumberController,
              labelText: 'input.phone_number'.tr(),
              keyboardType: TextInputType.phone,
              onChanged: context.personalDataBloc.setPhoneNumber,
            ),
            const SizedBox(height: 24.0),
            HealthInput(
              initialValue: state.email,
              labelText: 'input.email'.tr(),
              keyboardType: TextInputType.emailAddress,
              onChanged: context.personalDataBloc.setEmail,
            ),
          ],
        );
      },
    );
  }

  Widget _buildAvatarPicker(
    BuildContext context,
    ProfileState state,
  ) {
    return GestureDetector(
      onTap: () async {
        final imagePicker = ImagePicker();
        final image = await imagePicker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          context.personalDataBloc.pickAvatar(image.path);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: AppColors.purpleLightGrey.withOpacity(0.25),
            foregroundImage: state.avatar,
            child: SvgPicture.asset(
              AppResources.avatar,
              width: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'text.change_photo'.tr(),
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _buildSaveButton() {
    return BlocSelector<PersonalDataBloc, ProfileState, ProfileStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return HealthFlatButton(
          onPressed: context.personalDataBloc.saveData,
          isLoading: status == ProfileStatus.processing,
          text: 'button.save_data'.tr(),
        );
      },
    );
  }
}
