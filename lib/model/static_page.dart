import 'package:equatable/equatable.dart';

export 'plan_price.dart';

class StaticPage extends Equatable {
  const StaticPage({
    required this.key,
    required this.title,
    required this.content,
    required this.isActive,
  });

  final String key;
  final String title;
  final String content;
  final bool isActive;

  @override
  List<Object> get props => [
        key,
        title,
        content,
        isActive,
      ];
}
