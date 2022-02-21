part of 'about_us_bloc.dart';

abstract class AboutUsEvent extends Equatable {
  const AboutUsEvent();

  @override
  List<Object> get props => [];
}

class LoadPages extends AboutUsEvent {
  const LoadPages();
}
