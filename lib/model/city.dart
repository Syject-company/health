import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class CityFields {
  static const String id = 'id';
  static const String name = 'name';
}

class City extends Equatable {
  const City({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  static City fromJson(JsonMap json) {
    return City(
      id: json[CityFields.id],
      name: json[CityFields.name],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
