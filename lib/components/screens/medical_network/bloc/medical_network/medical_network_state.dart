part of 'medical_network_bloc.dart';

enum MedicalNetworkStatus {
  initial,
  error,
  warning,
}

enum CategoriesStatus {
  empty,
  fetching,
  loaded,
}

enum ProvidersStatus {
  empty,
  fetching,
  loaded,
}

enum MedicalNetworkView {
  list,
  map,
}

class MedicalNetworkState extends Equatable {
  const MedicalNetworkState._({
    required this.status,
    required this.categoriesStatus,
    required this.categories,
    this.selectedCategory,
    required this.providersStatus,
    required this.providers,
    required this.filteredProviders,
    required this.view,
    this.error,
  });

  const MedicalNetworkState.initial()
      : this._(
          status: MedicalNetworkStatus.initial,
          categoriesStatus: CategoriesStatus.empty,
          categories: const [],
          providersStatus: ProvidersStatus.empty,
          providers: const [],
          filteredProviders: const [],
          view: MedicalNetworkView.list,
        );

  final MedicalNetworkStatus status;
  final CategoriesStatus categoriesStatus;
  final List<Category> categories;
  final Category? selectedCategory;
  final ProvidersStatus providersStatus;
  final List<Provider> providers;
  final List<Provider> filteredProviders;
  final MedicalNetworkView view;
  final String? error;

  MedicalNetworkState copyWith({
    MedicalNetworkStatus? status,
    CategoriesStatus? categoriesStatus,
    List<Category>? categories,
    Nullable<Category>? selectedCategory,
    ProvidersStatus? providersStatus,
    List<Provider>? providers,
    List<Provider>? filteredProviders,
    MedicalNetworkView? view,
    Nullable<String>? error,
  }) =>
      MedicalNetworkState._(
        status: status ?? this.status,
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
        categories: categories ?? this.categories,
        selectedCategory: selectedCategory != null
            ? selectedCategory.value
            : this.selectedCategory,
        providersStatus: providersStatus ?? this.providersStatus,
        providers: providers ?? this.providers,
        filteredProviders: filteredProviders ?? this.filteredProviders,
        view: view ?? this.view,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        categoriesStatus,
        categories,
        selectedCategory,
        providersStatus,
        providers,
        filteredProviders,
        view,
        error,
      ];
}
