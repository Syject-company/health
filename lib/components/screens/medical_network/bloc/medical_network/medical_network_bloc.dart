import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/medical_network/data/category_service.dart';
import 'package:health_plus/components/screens/medical_network/data/provider_service.dart';
import 'package:health_plus/locator.dart';
import 'package:health_plus/model/category.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/utils/nullable.dart';

part 'medical_network_event.dart';
part 'medical_network_state.dart';

extension BlocExtension on BuildContext {
  MedicalNetworkBloc get medicalNetworkBloc => read<MedicalNetworkBloc>();
}

class MedicalNetworkBloc
    extends Bloc<MedicalNetworkEvent, MedicalNetworkState> {
  MedicalNetworkBloc() : super(const MedicalNetworkState.initial()) {
    on<LoadProviders>(_onLoadProviders);
    on<SelectCategory>(_onSelectCategory);
    on<ToggleView>(_onToggleView);

    add(const LoadProviders());
  }

  final CategoryService _categoryService = locator<CategoryService>();
  final ProviderService _providerService = locator<ProviderService>();

  final Category _defaultCategory =
      const Category(id: -1, name: 'All', image: '');

  void selectDefaultCategory() {
    add(SelectCategory(category: _defaultCategory));
  }

  void selectCategory(Category category) {
    add(SelectCategory(category: category));
  }

  void toggleView() {
    add(const ToggleView());
  }

  Future<void> _onLoadProviders(
    LoadProviders event,
    Emitter<MedicalNetworkState> emit,
  ) async {
    try {
      final getAllCategoriesResponse = await _categoryService.getAll();
      getAllCategoriesResponse
        ..onSuccess((data) {
          if (data != null) {
            emit(state.copyWith(
              categoriesStatus: CategoriesStatus.loaded,
              selectedCategory: Nullable(_defaultCategory),
              categories: [_defaultCategory, ...data.categories],
              error: Nullable(null),
            ));
          }
        })
        ..onError((errorMessage) {
          emit(state.copyWith(
            status: MedicalNetworkStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) {
          emit(state.copyWith(
            status: MedicalNetworkStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      getAllCategoriesResponse.handle();

      final getAllProvidersResponse = await _providerService.getAll();
      getAllProvidersResponse
        ..onSuccess((data) {
          if (data != null) {
            emit(state.copyWith(
              providersStatus: ProvidersStatus.loaded,
              providers: data.providers,
              filteredProviders: data.providers,
              error: Nullable(null),
            ));
          }
        })
        ..onError((errorMessage) {
          emit(state.copyWith(
            status: MedicalNetworkStatus.error,
            error: Nullable(errorMessage),
          ));
        })
        ..onNoConnection((errorMessage) {
          emit(state.copyWith(
            status: MedicalNetworkStatus.error,
            error: Nullable(errorMessage),
          ));
        });
      getAllProvidersResponse.handle();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<MedicalNetworkState> emit,
  ) async {
    if (event.category.id == _defaultCategory.id) {
      emit(state.copyWith(
        selectedCategory: Nullable(_defaultCategory),
        filteredProviders: state.providers,
      ));
      return;
    }

    emit(state.copyWith(
      selectedCategory: Nullable(event.category),
      filteredProviders: state.providers.where((provider) {
        return provider.categories.any((category) {
          return category.id == event.category.id;
        });
      }).toList(growable: false),
    ));
  }

  Future<void> _onToggleView(
    ToggleView event,
    Emitter<MedicalNetworkState> emit,
  ) async {
    emit(state.copyWith(
      view: state.view == MedicalNetworkView.map
          ? MedicalNetworkView.list
          : MedicalNetworkView.map,
    ));
  }
}
