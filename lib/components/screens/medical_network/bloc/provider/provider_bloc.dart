
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/model/provider.dart';

part 'provider_event.dart';
part 'provider_state.dart';

extension BlocExtension on BuildContext {
  ProviderBloc get providerBloc => read<ProviderBloc>();
}

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc({required Provider provider})
      : super(ProviderState.initial(provider));
}
