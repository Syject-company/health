import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/static_pages/data/static_pages_repository.dart';
import 'package:health_plus/model/static_page.dart';
import 'package:health_plus/utils/nullable.dart';

part 'privacy_policy_event.dart';
part 'privacy_policy_state.dart';

extension BlocExtension on BuildContext {
  PrivacyPolicyBloc get privacyPolicyBloc => read<PrivacyPolicyBloc>();
}

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState>
    with StaticPagesRepository {
  PrivacyPolicyBloc() : super(PrivacyPolicyState.initial()) {
    on<LoadPages>(_onLoadPages);

    add(const LoadPages());
  }

  void _onLoadPages(
    LoadPages event,
    Emitter<PrivacyPolicyState> emit,
  ) async {
    try {
      emit(state.copyWith(status: PrivacyPolicyStatus.processing));

      final getPageByKeyResponse = await getPageByKey('privacy');
      getPageByKeyResponse
        ..onSuccess((data) {
          if (data != null) {
            emit(state.copyWith(
              status: PrivacyPolicyStatus.loaded,
              pages: [...state.pages, data.page],
              error: Nullable(null),
            ));
          }
        })
        ..onError((errorMessage) async {
          emit(state.copyWith(
            status: PrivacyPolicyStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) async {
          emit(state.copyWith(
            status: PrivacyPolicyStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      await getPageByKeyResponse.handle();
    } catch (_) {
      emit(state.copyWith(
        status: PrivacyPolicyStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
    }
  }
}
