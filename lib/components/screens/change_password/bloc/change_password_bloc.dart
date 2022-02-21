import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/change_password/data/change_password_repository.dart';
import 'package:health_plus/components/screens/change_password/data/model/change_password_form.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/utils/errors.dart' as errors;
import 'package:health_plus/utils/nullable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

extension BlocExtension on BuildContext {
  ChangePasswordBloc get changePasswordBloc => read<ChangePasswordBloc>();
}

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState>
    with ChangePasswordRepository {
  ChangePasswordBloc() : super(const ChangePasswordState.initial()) {
    on<InputOldPassword>(_onInputOldPassword);
    on<InputNewPassword>(_onInputNewPassword);
    on<InputConfirmPassword>(_onInputConfirmPassword);
    on<SaveChanges>(_onSaveChanges);
  }

  void _onInputOldPassword(
    InputOldPassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      oldPassword: event.oldPassword,
      status: ChangePasswordStatus.input,
      error: Nullable(null),
    ));
  }

  void _onInputNewPassword(
    InputNewPassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      newPassword: event.newPassword,
      status: ChangePasswordStatus.input,
      error: Nullable(null),
    ));
  }

  void _onInputConfirmPassword(
    InputConfirmPassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      status: ChangePasswordStatus.input,
      error: Nullable(null),
    ));
  }

  void _onSaveChanges(
    SaveChanges event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(status: ChangePasswordStatus.processing));

    final form = ChangePasswordForm(
      currentPassword: state.oldPassword,
      password1: state.newPassword,
      password2: state.confirmPassword,
    );
    final changePasswordResponse = await changePassword(form);
    changePasswordResponse
      ..onSuccess((data) {
        emit(state.copyWith(
          status: ChangePasswordStatus.changed,
          error: Nullable(null),
        ));
      })
      ..onFailure((error) {
        final errorMessage = errors.join({
          'Old Password': error?.oldPasswordErrors,
          'New Password': error?.newPasswordErrors,
          'Confirm Password': error?.confirmPasswordErrors,
          '': error?.nonFieldErrors,
        });

        emit(state.copyWith(
          status: ChangePasswordStatus.error,
          error: Nullable(errorMessage.capitalize()),
        ));
      })
      ..onError((errorMessage) {
        emit(state.copyWith(
          status: ChangePasswordStatus.error,
          error: Nullable(errorMessage),
        ));
      })
      ..onNoConnection((errorMessage) {
        emit(state.copyWith(
          status: ChangePasswordStatus.error,
          error: Nullable(errorMessage),
        ));
      });
    await changePasswordResponse.handle();
  }

  void setOldPassword(String password) {
    add(InputOldPassword(password));
  }

  void setNewPassword(String password) {
    add(InputNewPassword(password));
  }

  void setConfirmPassword(String password) {
    add(InputConfirmPassword(password));
  }

  void saveChanges() {
    add(const SaveChanges());
  }
}
