part of 'provider_bloc.dart';

class ProviderState extends Equatable {
  const ProviderState._({required this.provider});

  factory ProviderState.initial(Provider provider) {
    return ProviderState._(provider: provider);
  }

  final Provider provider;

  @override
  List<Object> get props => [provider];
}
