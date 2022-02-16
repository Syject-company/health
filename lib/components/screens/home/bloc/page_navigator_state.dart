part of 'page_navigator_bloc.dart';

enum HomePage {
  main,
  medicalNetwork,
  offers,
  favourites,
  myAccount,
}

class PageNavigatorState extends Equatable {
  const PageNavigatorState._({required this.page});

  const PageNavigatorState.initial() : this._(page: 0);

  final int page;

  PageNavigatorState copyWith({
    int? page,
  }) =>
      PageNavigatorState._(
        page: page ?? this.page,
      );

  @override
  List<Object> get props => [page];
}

extension HomePageExtension on HomePage {
  int get value {
    switch (this) {
      case HomePage.main:
        return 0;
      case HomePage.medicalNetwork:
        return 1;
      case HomePage.offers:
        return 2;
      case HomePage.favourites:
        return 3;
      case HomePage.myAccount:
        return 4;
      default:
        return 0;
    }
  }
}

