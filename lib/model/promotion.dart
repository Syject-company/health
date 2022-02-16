import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

import 'category.dart';

abstract class PromotionFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String isRequireSubscription = 'require_subscription';
  static const String type = 'type';
  static const String amount = 'amount';
  static const String before = 'before';
  static const String offer = 'offer';
  static const String categories = 'categories';
  static const String image = 'image';
}

class Promotion extends Equatable {
  const Promotion({
    this.id,
    required this.name,
    required this.description,
    required this.isRequireSubscription,
    required this.type,
    required this.amount,
    this.before,
    required this.offer,
    required this.categories,
    this.image,
  });

  final int? id;
  final String name;
  final String description;
  final bool isRequireSubscription;
  final String type;
  final int amount;
  final int? before;
  final String offer;
  final List<Category> categories;
  final String? image;

  static Promotion fromJson(JsonMap json) {
    final categories = jsonArrayToList<Category>(
      json[PromotionFields.categories],
      Category.fromJson,
    );

    return Promotion(
      id: json[PromotionFields.id],
      name: json[PromotionFields.name],
      description: json[PromotionFields.description],
      isRequireSubscription: json[PromotionFields.isRequireSubscription],
      type: json[PromotionFields.type],
      amount: json[PromotionFields.amount],
      before: json[PromotionFields.before],
      offer: json[PromotionFields.offer],
      categories: categories,
      image: json[PromotionFields.image],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        isRequireSubscription,
        type,
        amount,
        before,
        offer,
        categories,
        image,
      ];
}
