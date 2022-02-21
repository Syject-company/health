import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/reset_password/data/model/reset_password_form.dart';
import 'package:health_plus/components/screens/reset_password/data/reset_password_repository.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/utils/errors.dart' as errors;
import 'package:health_plus/utils/nullable.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

extension BlocExtension on BuildContext {
  ResetPasswordBloc get resetPasswordBloc => read<ResetPasswordBloc>();
}

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>
    with ResetPasswordRepository {
  ResetPasswordBloc() : super(const ResetPasswordState.initial()) {
    on<InputEmail>(_onInputEmail);
    on<ResetPassword>(_onResetPassword);
  }

  void _onInputEmail(
    InputEmail event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
      status: ResetPasswordStatus.input,
      error: Nullable(null),
    ));
  }

  void _onResetPassword(
    ResetPassword event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ResetPasswordStatus.processing));
    final form = ResetPasswordForm(
      email: state.email,
    );

    final resetPasswordResponse = await resetPassword(form);
    resetPasswordResponse
      ..onSuccess((data) {
        emit(state.copyWith(
          status: ResetPasswordStatus.sent,
          error: Nullable(null),
        ));
      })
      ..onFailure((error) {
        final errorMessage = errors.join({
          'Email': error?.emailErrors,
          '': error?.nonFieldErrors,
        });

        emit(state.copyWith(
          status: ResetPasswordStatus.error,
          error: Nullable(errorMessage.capitalize()),
        ));
      })
      ..onError((errorMessage) {
        emit(state.copyWith(
          status: ResetPasswordStatus.error,
          error: Nullable(errorMessage),
        ));
      })
      ..onNoConnection((errorMessage) {
        emit(state.copyWith(
          status: ResetPasswordStatus.error,
          error: Nullable(errorMessage),
        ));
      });
    await resetPasswordResponse.handle();
  }

  void setEmail(String email) {
    add(InputEmail(email));
  }

  void reset() {
    add(const ResetPassword());
  }
}
