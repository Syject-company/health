import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_navigator_event.dart';
part 'page_navigator_state.dart';

extension CubitExtension on BuildContext {
  PageNavigatorBloc get pageNavigatorBloc => read<PageNavigatorBloc>();
}

class PageNavigatorBloc extends Bloc<PageNavigatorEvent, PageNavigatorState> {
  PageNavigatorBloc() : super(const PageNavigatorState.initial()) {
    on<NavigateTo>(_onNavigateTo);
  }

  void _onNavigateTo(
    NavigateTo event,
    Emitter<PageNavigatorState> emit,
  ) async {
    emit(state.copyWith(page: event.page));
  }

  void navigateTo(int page) {
    add(NavigateTo(page));
  }
}
