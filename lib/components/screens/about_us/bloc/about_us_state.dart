part of 'about_us_bloc.dart';

enum AboutUsStatus {
  initial,
  processing,
  loaded,
  warning,
  error,
}

class AboutUsState extends Equatable {
  const AboutUsState._({
    required this.status,
    required this.pages,
    this.error,
  });

  factory AboutUsState.initial() {
    return const AboutUsState._(
      status: AboutUsStatus.initial,
      pages: [],
    );
  }

  final AboutUsStatus status;
  final List<StaticPage> pages;
  final String? error;

  AboutUsState copyWith({
    AboutUsStatus? status,
    List<StaticPage>? pages,
    Nullable<String>? error,
  }) =>
      AboutUsState._(
        status: status ?? this.status,
        pages: pages ?? this.pages,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        pages,
        error,
      ];
}
