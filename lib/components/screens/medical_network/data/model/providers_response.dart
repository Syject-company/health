import 'package:equatable/equatable.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

abstract class ProvidersResponseFields {
  static const String count = 'count';
  static const String next = 'next';
  static const String previous = 'previous';
  static const String providers = 'results';
}

class ProvidersResponse extends Equatable {
  const ProvidersResponse({
    required this.count,
    this.next,
    this.previous,
    required this.providers,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<Provider> providers;

  static ProvidersResponse fromJson(JsonMap json) {
    final providers = jsonArrayToList<Provider>(
      json[ProvidersResponseFields.providers],
      Provider.fromJson,
    );

    return ProvidersResponse(
      count: json[ProvidersResponseFields.count],
      next: json[ProvidersResponseFields.next],
      previous: json[ProvidersResponseFields.previous],
      providers: providers,
    );
  }

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        providers,
      ];
}
