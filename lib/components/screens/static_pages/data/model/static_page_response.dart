import 'package:equatable/equatable.dart';
import 'package:health_plus/model/static_page.dart';
import 'package:health_plus/typedefs.dart';

abstract class StaticPageResponseFields {
  static const String key = 'key';
  static const String title = 'title';
  static const String content = 'value';
  static const String isActive = 'is_active';
}

class StaticPageResponse extends Equatable {
  const StaticPageResponse({required this.page});

  final StaticPage page;

  static StaticPageResponse fromJson(JsonMap json) {
    return StaticPageResponse(
      page: StaticPage(
        key: json[StaticPageResponseFields.key],
        title: json[StaticPageResponseFields.title],
        content: json[StaticPageResponseFields.content],
        isActive: json[StaticPageResponseFields.isActive],
      ),
    );
  }

  @override
  List<Object> get props => [page];
}
