import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class PlanPriceFields {
  static const String id = 'id';
  static const String phase = 'phase';
  static const String price = 'price';
  static const String period = 'period';
  static const String numberOfUsers = 'number_of_users';
}

class PlanPrice extends Equatable {
  const PlanPrice({
    required this.id,
    required this.phase,
    required this.price,
    required this.period,
    required this.numberOfUsers,
  });

  final int id;
  final String phase;
  final String price;
  final int period;
  final int numberOfUsers;

  static PlanPrice fromJson(JsonMap json) {
    return PlanPrice(
      id: json[PlanPriceFields.id],
      numberOfUsers: json[PlanPriceFields.numberOfUsers],
      period: json[PlanPriceFields.period],
      phase: json[PlanPriceFields.phase],
      price: json[PlanPriceFields.price],
    );
  }

  @override
  List<Object> get props => [
        id,
        phase,
        price,
        period,
        numberOfUsers,
      ];
}
