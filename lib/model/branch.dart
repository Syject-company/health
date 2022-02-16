import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class BranchFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String location = 'location';
  static const String phoneNumber = 'phone_number';
}

class Branch extends Equatable {
  const Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.phoneNumber,
  });

  final int id;
  final String name;
  final String location;
  final String phoneNumber;

  static Branch fromJson(JsonMap json) {
    return Branch(
      id: json[BranchFields.id],
      name: json[BranchFields.name],
      location: json[BranchFields.location],
      phoneNumber: json[BranchFields.phoneNumber],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        phoneNumber,
      ];
}
