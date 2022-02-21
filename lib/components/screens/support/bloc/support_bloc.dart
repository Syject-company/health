import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/screens/support/data/model/save_profile_form.dart';
import 'package:health_plus/components/screens/support/data/support_repository.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/model/profile.dart';
import 'package:health_plus/utils/errors.dart' as errors;
import 'package:health_plus/utils/nullable.dart';

part 'support_event.dart';
part 'support_state.dart';

extension BlocExtension on BuildContext {
  SupportBloc get supportBloc => read<SupportBloc>();
}

class SupportBloc extends Bloc<SupportEvent, SupportState>
    with SupportRepository {
  SupportBloc({required AccountBloc accountBloc})
      : super(SupportState.initial(accountBloc.state.profile)) {
    on<InputFullName>(_onInputFullName);
    on<InputPhoneNumber>(_onInputPhoneNumber);
    on<InputEmail>(_onInputEmail);
    on<InputSubject>(_onInputTopic);
    on<InputDescription>(_onInputDescription);
    on<SendMessage>(_onSendMessage);
  }

  void _onInputFullName(
    InputFullName event,
    Emitter<SupportState> emit,
  ) async {
    emit(state.copyWith(
      status: SupportStatus.input,
      fullName: event.fullName,
      error: Nullable(null),
    ));
  }

  void _onInputPhoneNumber(
    InputPhoneNumber event,
    Emitter<SupportState> emit,
  ) async {
    emit(state.copyWith(
      status: SupportStatus.input,
      phoneNumber: event.phoneNumber,
      error: Nullable(null),
    ));
  }

  void _onInputEmail(
    InputEmail event,
    Emitter<SupportState> emit,
  ) async {
    emit(state.copyWith(
      status: SupportStatus.input,
      email: event.email,
      error: Nullable(null),
    ));
  }

  void _onInputTopic(
    InputSubject event,
    Emitter<SupportState> emit,
  ) async {
    emit(state.copyWith(
      status: SupportStatus.input,
      subject: event.subject,
      error: Nullable(null),
    ));
  }

  void _onInputDescription(
    InputDescription event,
    Emitter<SupportState> emit,
  ) async {
    emit(state.copyWith(
      status: SupportStatus.input,
      description: event.description,
      error: Nullable(null),
    ));
  }

  void _onSendMessage(
    SendMessage event,
    Emitter<SupportState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SupportStatus.processing));

      final phoneNumber = state.phoneNumber.isNotEmpty
          ? '+${state.phoneNumber}'
          : state.phoneNumber;

      final form = SendMessageForm(
        fullName: state.fullName,
        phoneNumber: phoneNumber,
        type: 'c',
        subject: state.subject,
        description: state.description,
      );

      final sendMessageResponse = await sendMessage(form);
      sendMessageResponse
        ..onSuccess((data) {
          emit(state.copyWith(
            status: SupportStatus.sent,
            error: Nullable(null),
          ));
        })
        ..onFailure((error) {
          final errorMessage = errors.join({
            'Full Name': error?.fullNameErrors,
            'Phone Number': error?.phoneNumberErrors,
            'Subject': error?.subjectErrors,
            'Description': error?.descriptionErrors,
          });

          emit(state.copyWith(
            status: SupportStatus.error,
            error: Nullable(errorMessage.capitalize()),
          ));
        })
        ..onError((errorMessage) async {
          emit(state.copyWith(
            status: SupportStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) async {
          emit(state.copyWith(
            status: SupportStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      await sendMessageResponse.handle();
    } catch (_) {
      emit(state.copyWith(
        status: SupportStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
    }
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

  void setSubject(String subject) {
    add(InputSubject(subject));
  }

  void setDescription(String description) {
    add(InputDescription(description));
  }

  void send() {
    add(const SendMessage());
  }
}
