import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class CategoryFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String image = 'image';
}

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.image,
  });

  final int id;
  final String name;
  final String? image;

  static Category fromJson(JsonMap json) {
    return Category(
      id: json[CategoryFields.id],
      name: json[CategoryFields.name],
      // TODO: temp image
      image: 'https://www.crsmu.ru/wp-content/uploads/2019/05/Pharmacy.jpg',
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}
