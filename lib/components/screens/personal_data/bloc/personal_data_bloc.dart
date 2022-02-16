import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_constants.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/screens/personal_data/data/model/save_profile_form.dart';
import 'package:health_plus/components/screens/personal_data/data/profile_repository.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/model/profile.dart';
import 'package:health_plus/utils/errors.dart' as errors;
import 'package:health_plus/utils/nullable.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

extension BlocExtension on BuildContext {
  PersonalDataBloc get personalDataBloc => read<PersonalDataBloc>();
}

class PersonalDataBloc extends Bloc<PersonalDataEvent, ProfileState>
    with ProfileRepository {
  PersonalDataBloc({required AccountBloc accountBloc})
      : _accountBloc = accountBloc,
        super(ProfileState.initial(accountBloc.state.profile)) {
    on<PickAvatar>(_onPickAvatar);
    on<InputFullName>(_onInputFullName);
    on<InputPhoneNumber>(_onInputPhoneNumber);
    on<InputEmail>(_onInputEmail);
    on<SaveData>(_onSaveData);
  }

  final AccountBloc _accountBloc;

  void _onPickAvatar(
    PickAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    final avatarFile = File(event.imagePath);

    emit(state.copyWith(
      status: ProfileStatus.input,
      avatar: Nullable(FileImage(avatarFile)),
      avatarFile: Nullable(avatarFile),
      error: Nullable(null),
    ));
  }

  void _onInputFullName(
    InputFullName event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.input,
      fullName: event.fullName,
      error: Nullable(null),
    ));
  }

  void _onInputPhoneNumber(
    InputPhoneNumber event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.input,
      phoneNumber: event.phoneNumber,
      error: Nullable(null),
    ));
  }

  void _onInputEmail(
    InputEmail event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ProfileStatus.input,
      email: event.email,
      error: Nullable(null),
    ));
  }

  void _onSaveData(
    SaveData event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      if (state.fullName.trim().isEmpty) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          error: Nullable('Full Name can not be empty.'),
        ));
        return;
      }

      emit(state.copyWith(status: ProfileStatus.processing));

      final fullName = state.fullName.trim();
      final firstSpaceIndex = fullName.indexOf(' ');
      final firstName = firstSpaceIndex != -1
          ? fullName.substring(0, firstSpaceIndex)
          : fullName;
      final lastName = firstSpaceIndex != -1
          ? fullName.substring(firstSpaceIndex + 1, fullName.length)
          : '';
      final phoneNumber =
          state.phoneNumber.isNotEmpty ? '+${state.phoneNumber}' : '';

      final files = <String, File?>{
        'avatar': state.avatarFile,
      };
      final form = SaveProfileForm(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: state.email,
      );
      final saveProfileResponse = await saveProfile(files, form);
      saveProfileResponse
        ..onSuccess((data) {
          if (data != null) {
            _accountBloc.updateProfile(data.profile);
          }

          emit(state.copyWith(
            status: ProfileStatus.saved,
            error: Nullable(null),
          ));
        })
        ..onFailure((error) {
          final errorMessage = errors.join({
            '': [
              ...(error?.emailErrors ?? []),
              ...(error?.phoneNumberErrors ?? []),
            ],
          });

          emit(state.copyWith(
            status: ProfileStatus.error,
            error: Nullable(errorMessage.toString().trim().capitalize()),
          ));
        })
        ..onError((errorMessage) async {
          emit(state.copyWith(
            status: ProfileStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) async {
          emit(state.copyWith(
            status: ProfileStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      await saveProfileResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
    }
  }

  void pickAvatar(String imagePath) {
    add(PickAvatar(imagePath));
  }

  void setFullName(String fullName) {
    add(InputFullName(fullName));
  }

  void setPhoneNumber(String phoneNumber) {
    add(InputPhoneNumber(phoneNumber));
  }

  void setEmail(String email) {
    add(InputEmail(email));
  }

  void saveData() {
    add(const SaveData());
  }
}
