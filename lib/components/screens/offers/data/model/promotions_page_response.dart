import 'package:equatable/equatable.dart';
import 'package:health_plus/model/promotion.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

abstract class PromotionsPageResponseFields {
  static const String count = 'count';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String results = 'results';
}

class PromotionsPageResponse extends Equatable {
  const PromotionsPageResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<Promotion> results;

  static PromotionsPageResponse fromJson(JsonMap json) {
    final results = jsonArrayToList<Promotion>(
      json[PromotionsPageResponseFields.results],
      Promotion.fromJson,
    );

    return PromotionsPageResponse(
      count: json[PromotionsPageResponseFields.count],
      next: json[PromotionsPageResponseFields.next],
      previous: json[PromotionsPageResponseFields.previous],
      results: results,
    );
  }

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}
