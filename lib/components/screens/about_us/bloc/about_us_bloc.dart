import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/static_pages/data/static_pages_repository.dart';
import 'package:health_plus/model/static_page.dart';
import 'package:health_plus/utils/nullable.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

extension BlocExtension on BuildContext {
  AboutUsBloc get aboutUsBloc => read<AboutUsBloc>();
}

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState>
    with StaticPagesRepository {
  AboutUsBloc() : super(AboutUsState.initial()) {
    on<LoadPages>(_onLoadPages);

    add(const LoadPages());
  }

  void _onLoadPages(
    LoadPages event,
    Emitter<AboutUsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AboutUsStatus.processing));

      final getPageByKeyResponse = await getPageByKey('about_us');
      getPageByKeyResponse
        ..onSuccess((data) {
          if (data != null) {
            emit(state.copyWith(
              status: AboutUsStatus.loaded,
              pages: [...state.pages, data.page],
              error: Nullable(null),
            ));
          }
        })
        ..onError((errorMessage) async {
          emit(state.copyWith(
            status: AboutUsStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) async {
          emit(state.copyWith(
            status: AboutUsStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      await getPageByKeyResponse.handle();
    } catch (_) {
      emit(state.copyWith(
        status: AboutUsStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
    }
  }
}
