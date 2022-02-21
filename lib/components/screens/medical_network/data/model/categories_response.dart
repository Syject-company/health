import 'package:equatable/equatable.dart';
import 'package:health_plus/model/category.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

abstract class CategoriesResponseFields {
  static const String count = 'count';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String categories = 'results';
}

class CategoriesResponse extends Equatable {
  const CategoriesResponse({
    required this.count,
    this.next,
    this.previous,
    required this.categories,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<Category> categories;

  static CategoriesResponse fromJson(JsonMap json) {
    final categories = jsonArrayToList<Category>(
      json[CategoriesResponseFields.categories],
      Category.fromJson,
    );

    return CategoriesResponse(
      count: json[CategoriesResponseFields.count],
      next: json[CategoriesResponseFields.next],
      previous: json[CategoriesResponseFields.previous],
      categories: categories,
    );
  }

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        categories,
      ];
}
