import 'package:equatable/equatable.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

abstract class FavouritesPageResponseFields {
  static const String count = 'count';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String results = 'results';
}

class FavouritesPageResponse extends Equatable {
  const FavouritesPageResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<Provider> results;

  static FavouritesPageResponse fromJson(JsonMap json) {
    final results = jsonArrayToList<Provider>(
      json[FavouritesPageResponseFields.results],
      Provider.fromJson,
    );

    return FavouritesPageResponse(
      count: json[FavouritesPageResponseFields.count],
      next: json[FavouritesPageResponseFields.next],
      previous: json[FavouritesPageResponseFields.previous],
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
