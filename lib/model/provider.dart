import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/json_util.dart';

import 'branch.dart';
import 'category.dart';
import 'city.dart';
import 'promotion.dart';
import 'social_media.dart';

abstract class ProviderFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String phoneNumber = 'phone_number';
  static const String description = 'description';
  static const String website = 'website';
  static const String logo = 'logo';
  static const String branches = 'branches';
  static const String promotions = 'promotions';
  static const String categories = 'categories';
  static const String socials = 'social_media';
  static const String cities = 'cities';
}

class Provider extends Equatable {
  const Provider({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.description,
    required this.website,
    required this.logo,
    required this.branches,
    required this.promotions,
    required this.categories,
    required this.socials,
    required this.cities,
  });

  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String description;
  final String website;
  final String logo;
  final List<Branch> branches;
  final List<Promotion> promotions;
  final List<Category> categories;
  final List<SocialMedia> socials;
  final List<City> cities;

  static Provider fromJson(JsonMap json) {
    final branches = jsonArrayToList<Branch>(
      json[ProviderFields.branches],
      Branch.fromJson,
    );
    final promotions = jsonArrayToList<Promotion>(
      json[ProviderFields.promotions],
      Promotion.fromJson,
    );
    final categories = jsonArrayToList<Category>(
      json[ProviderFields.categories],
      Category.fromJson,
    );
    final socials = jsonArrayToList<SocialMedia>(
      json[ProviderFields.socials],
      SocialMedia.fromJson,
    );
    final cities = jsonArrayToList<City>(
      json[ProviderFields.cities],
      City.fromJson,
    );

    return Provider(
      id: json[ProviderFields.id],
      name: json[ProviderFields.name],
      email: json[ProviderFields.email],
      phoneNumber: json[ProviderFields.phoneNumber],
      description: json[ProviderFields.description],
      website: json[ProviderFields.website],
      logo: json[ProviderFields.logo],
      branches: branches,
      promotions: promotions,
      categories: categories,
      socials: socials,
      cities: cities,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        email,
        phoneNumber,
        description,
        website,
        logo,
        branches,
        promotions,
        categories,
        socials,
        cities,
      ];
}
