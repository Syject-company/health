import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/screens/offers/data/promotions_service.dart';
import 'package:health_plus/locator.dart';
import 'package:health_plus/model/promotion.dart';
import 'package:health_plus/utils/nullable.dart';
import 'package:health_plus/utils/session_manager.dart';

part 'offers_event.dart';

part 'offers_state.dart';

extension BlocExtension on BuildContext {
  OffersBloc get offersBloc => read<OffersBloc>();
}

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc({required AccountBloc accountBloc})
      : super(const OffersState.initial()) {
    on<LoadOffers>(_onLoadFavourites);
    on<ClearOffers>(_onClearFavourites);

    _accountBlocStateSubscription = accountBloc.stream.listen((state) {
      if (state.role == UserRole.guest) {
        add(const ClearOffers());
      } else {
        _loadOffers();
      }
    });

    _loadOffers();
  }

  final PromotionService _promotionService = locator<PromotionService>();

  late final StreamSubscription _accountBlocStateSubscription;

  @override
  Future<void> close() {
    _accountBlocStateSubscription.cancel();
    return super.close();
  }

  Promotion? findPromotion(int? id) {
    return state.promotions.firstWhereOrNull((promotion) {
      return promotion.id == id;
    });
  }

  bool contains(Promotion promotion) {
    return findPromotion(promotion.id) != null;
  }

  Future<void> _onLoadFavourites(
    LoadOffers event,
    Emitter<OffersState> emit,
  ) async {
    try {
      emit(state.copyWith(status: OffersStatus.fetching));

      final getAllPromotionsResponse = await _promotionService.getAll();
      getAllPromotionsResponse.onSuccess((data) {
        if (data != null) {
          emit(state.copyWith(
            status: OffersStatus.loaded,
            promotions: data.results,
            error: Nullable(null),
          ));
        }
      });
      getAllPromotionsResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: OffersStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
      throw Exception(e);
    }
  }

  Future<void> _onClearFavourites(
    ClearOffers event,
    Emitter<OffersState> emit,
  ) async {
    emit(state.copyWith(
      status: OffersStatus.empty,
      promotions: const [],
      error: Nullable(null),
    ));
  }

  void _loadOffers() async {
    if (await SessionManager.isAuthenticated) {
      add(const LoadOffers());
    }
  }
}
