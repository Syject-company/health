import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/login/data/login_repository.dart';
import 'package:health_plus/components/screens/login/data/model/login_form.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/utils/errors.dart' as errors;
import 'package:health_plus/utils/nullable.dart';
import 'package:health_plus/utils/session_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

extension BlocExtension on BuildContext {
  LoginBloc get loginBloc => read<LoginBloc>();
}

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginRepository {
  LoginBloc({
    required AccountBloc accountBloc,
  })  : _accountBloc = accountBloc,
        super(const LoginState.initial()) {
    on<Login>(_onLogin);
    on<InputEmail>(_onInputEmail);
    on<InputPassword>(_onInputPassword);
  }

  final AccountBloc _accountBloc;

  Future<void> _onLogin(
    Login event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: LoginStatus.processing));

      final form = LoginForm(
        email: state.email,
        password: state.password,
      );
      final signInResponse = await signIn(form);
      signInResponse
        ..onSuccess((data) async {
          if (data != null) {
            await SessionManager.initialize(data.token);
            _accountBloc.initializeProfile(data.profile);

            emit(state.copyWith(
              status: LoginStatus.logged,
              error: Nullable(null),
            ));
          }
        })
        ..onFailure((error) {
          final errorMessage = errors.join({
            'Email': error?.emailErrors,
            'Password': error?.passwordErrors,
            '': error?.nonFieldErrors,
          });

          emit(state.copyWith(
            status: LoginStatus.error,
            error: Nullable(errorMessage.capitalize()),
          ));
        })
        ..onError((errorMessage) async {
          emit(state.copyWith(
            status: LoginStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) async {
          emit(state.copyWith(
            status: LoginStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      await signInResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
    }
  }

  void _onInputEmail(
    InputEmail event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
      status: LoginStatus.input,
      error: Nullable(null),
    ));
  }

  void _onInputPassword(
    InputPassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      password: event.password,
      status: LoginStatus.input,
      error: Nullable(null),
    ));
  }

  void setEmail(String email) {
    add(InputEmail(email));
  }

  void setPassword(String password) {
    add(InputPassword(password));
  }

  void login() {
    add(const Login());
  }
}
