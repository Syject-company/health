import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

import 'plan_price.dart';

export 'plan_price.dart';

abstract class PlanFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String prices = 'prices';
}

class Plan extends Equatable {
  const Plan({
    required this.id,
    required this.name,
    required this.prices,
  });

  final int id;
  final String name;
  final List<PlanPrice> prices;

  static Plan fromJson(JsonMap json) {
    final prices = jsonArrayToList<PlanPrice>(
      json[PlanFields.prices],
      PlanPrice.fromJson,
    );

    return Plan(
      id: json[PlanFields.id],
      name: json[PlanFields.name],
      prices: prices,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        prices,
      ];
}
