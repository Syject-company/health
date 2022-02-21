import 'package:equatable/equatable.dart';
import 'package:health_plus/model/plan.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

abstract class PlansPageResponseFields {
  static const String count = 'count';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String results = 'results';
}

class PlansPageResponse extends Equatable {
  const PlansPageResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<Plan> results;

  static PlansPageResponse fromJson(JsonMap json) {
    final results = jsonArrayToList<Plan>(
      json[PlansPageResponseFields.results],
      Plan.fromJson,
    );

    return PlansPageResponse(
      count: json[PlansPageResponseFields.count],
      next: json[PlansPageResponseFields.next],
      previous: json[PlansPageResponseFields.previous],
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
