part of 'page_navigator_bloc.dart';

abstract class PageNavigatorEvent extends Equatable {
  const PageNavigatorEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends PageNavigatorEvent {
  const NavigateTo(this.page);

  final int page;

  @override
  List<Object> get props => [page];
}
