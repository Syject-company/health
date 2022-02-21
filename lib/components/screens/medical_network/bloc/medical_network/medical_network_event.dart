part of 'medical_network_bloc.dart';

abstract class MedicalNetworkEvent extends Equatable {
  const MedicalNetworkEvent();

  @override
  List<Object> get props => [];
}

class LoadProviders extends MedicalNetworkEvent {
  const LoadProviders();
}

class SelectCategory extends MedicalNetworkEvent {
  const SelectCategory({required this.category});

  final Category category;

  @override
  List<Object> get props => [category];
}

class ToggleView extends MedicalNetworkEvent {
  const ToggleView();
}
