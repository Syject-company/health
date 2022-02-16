import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/registration/data/model/registration_form.dart';
import 'package:health_plus/components/screens/registration/data/registration_repository.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/utils/errors.dart' as errors;
import 'package:health_plus/utils/nullable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

extension BlocExtension on BuildContext {
  RegistrationBloc get registrationBloc => read<RegistrationBloc>();
}

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>
    with RegistrationRepository {
  RegistrationBloc() : super(const RegistrationState.initial()) {
    on<InputFullName>(_onInputFullName);
    on<InputEmail>(_onInputEmail);
    on<InputPassword>(_onInputPassword);
    on<Register>(_onRegister);
  }

  void _onInputFullName(
    InputFullName event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(
      fullName: event.fullName,
      status: RegistrationStatus.input,
      error: Nullable(null),
    ));
  }

  void _onInputEmail(
    InputEmail event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
      status: RegistrationStatus.input,
      error: Nullable(null),
    ));
  }

  void _onInputPassword(
    InputPassword event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(
      password: event.password,
      status: RegistrationStatus.input,
      error: Nullable(null),
    ));
  }

  void _onRegister(
    Register event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(status: RegistrationStatus.processing));

    if (state.fullName.isEmpty) {
      emit(state.copyWith(
        status: RegistrationStatus.error,
        error: Nullable('Full Name: This field may not be blank.'),
      ));
      return;
    }

    final fullName = state.fullName.trim();
    final firstSpaceIndex = fullName.indexOf(' ');
    final firstName = firstSpaceIndex != -1
        ? fullName.substring(0, firstSpaceIndex)
        : fullName;
    final lastName = firstSpaceIndex != -1
        ? fullName.substring(firstSpaceIndex + 1, fullName.length)
        : '';

    final form = RegistrationForm(
      firstName: firstName,
      lastName: lastName,
      email: state.email,
      password1: state.password,
      password2: state.password,
    );
    final signUpResponse = await signUp(form);
    signUpResponse
      ..onSuccess((data) {
        emit(state.copyWith(
          status: RegistrationStatus.registered,
          error: Nullable(null),
        ));
      })
      ..onFailure((error) {
        final errorMessage = errors.join({
          'Email': error?.emailErrors,
          'Password': error?.passwordErrors,
          '': error?.nonFieldErrors,
        });

        emit(state.copyWith(
          status: RegistrationStatus.error,
          error: Nullable(errorMessage.capitalize()),
        ));
      })
      ..onError((errorMessage) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          error: Nullable(errorMessage),
        ));
      })
      ..onNoConnection((errorMessage) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          error: Nullable(errorMessage),
        ));
      });
    await signUpResponse.handle();
  }

  void setFullName(String fullName) {
    add(InputFullName(fullName));
  }

  void setEmail(String email) {
    add(InputEmail(email));
  }

  void setPassword(String password) {
    add(InputPassword(password));
  }

  void register() {
    add(const Register());
  }
}
