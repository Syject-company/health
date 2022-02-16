import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/favourites/data/favourite_service.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/locator.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/utils/nullable.dart';
import 'package:health_plus/utils/session_manager.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

extension BlocExtension on BuildContext {
  FavouritesBloc get favouritesBloc => read<FavouritesBloc>();
}

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc({required AccountBloc accountBloc})
      : super(const FavouritesState.initial()) {
    on<LoadFavourites>(_onLoadFavourites);
    on<AddToFavourites>(_onAddToFavourites);
    on<RemoveFromFavourites>(_onRemoveFromFavourites);
    on<ClearFavourites>(_onClearFavourites);

    _accountBlocStateSubscription = accountBloc.stream.listen((state) {
      if (state.role == UserRole.guest) {
        add(const ClearFavourites());
      } else {
        _loadFavourites();
      }
    });

    _loadFavourites();
  }

  final FavouriteService _favouriteService = locator<FavouriteService>();

  late final StreamSubscription _accountBlocStateSubscription;

  @override
  Future<void> close() {
    _accountBlocStateSubscription.cancel();
    return super.close();
  }

  Provider? findProvider(int id) {
    return state.providers.firstWhereOrNull((provider) {
      return provider.id == id;
    });
  }

  bool contains(Provider provider) {
    return findProvider(provider.id) != null;
  }

  void addToFavourites(Provider provider) {
    add(AddToFavourites(provider: provider));
  }

  void removeFromFavourites(Provider provider) {
    add(RemoveFromFavourites(provider: provider));
  }

  Future<void> _onLoadFavourites(
    LoadFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FavouritesStatus.fetching));

      final getAllFavouritesResponse = await _favouriteService.getAll();
      getAllFavouritesResponse.onSuccess((data) {
        if (data != null) {
          emit(state.copyWith(
            status: FavouritesStatus.loaded,
            providers: data.results,
            error: Nullable(null),
          ));
        }
      });
      getAllFavouritesResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: FavouritesStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
      throw Exception(e);
    }
  }

  Future<void> _onAddToFavourites(
    AddToFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final addToFavouritesResponse =
          await _favouriteService.addToFavourites(event.provider.id);
      addToFavouritesResponse.onSuccess((data) {
        emit(state.copyWith(
          providers: [...state.providers, event.provider],
        ));
      });
      addToFavouritesResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: FavouritesStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
      throw Exception(e);
    }
  }

  Future<void> _onRemoveFromFavourites(
    RemoveFromFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final removeFromFavouritesResponse =
          await _favouriteService.removeFromFavourites(event.provider.id);
      removeFromFavouritesResponse.onSuccess((data) {
        emit(state.copyWith(
          providers: state.providers.where((provider) {
            return provider.id != event.provider.id;
          }).toList(growable: false),
        ));
      });
      removeFromFavouritesResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: FavouritesStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
      throw Exception(e);
    }
  }

  Future<void> _onClearFavourites(
    ClearFavourites event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(state.copyWith(
      status: FavouritesStatus.empty,
      providers: const [],
      error: Nullable(null),
    ));
  }

  void _loadFavourites() async {
    if (await SessionManager.isAuthenticated) {
      add(const LoadFavourites());
    }
  }
}
