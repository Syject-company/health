import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/my_account/data/account_repository.dart';
import 'package:health_plus/model/profile.dart';
import 'package:health_plus/utils/session_manager.dart';

part 'account_event.dart';
part 'account_state.dart';

extension BlocExtension on BuildContext {
  AccountBloc get accountBloc => read<AccountBloc>();
}

class AccountBloc extends Bloc<AccountEvent, AccountState>
    with AccountRepository {
  AccountBloc() : super(AccountState.guest()) {
    on<InitializeProfile>(_onInitializeProfile);
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<ClearProfile>(_onClearProfile);

    _loadProfile();
  }

  Future<void> _onInitializeProfile(
    InitializeProfile event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountState.user(event.profile));
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<AccountState> emit,
  ) async {
    try {
      final getProfileResponse = await getProfile();
      getProfileResponse.onSuccess((data) {
        if (data != null) {
          emit(AccountState.user(data.profile));
        }
      });
      await getProfileResponse.handle();
    } catch (_) {}
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountState.user(event.profile));
  }

  Future<void> _onClearProfile(
    ClearProfile event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountState.guest());
  }

  void initializeProfile(Profile profile) {
    add(InitializeProfile(profile: profile));
  }

  void updateProfile(Profile profile) {
    add(UpdateProfile(profile: profile));
  }

  void clearProfile() {
    add(const ClearProfile());
  }

  void _loadProfile() async {
    if (await SessionManager.isAuthenticated) {
      add(const LoadProfile());
    }
  }
}
