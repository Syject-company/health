import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

enum Social {
  twitter,
  instagram,
  snapchat,
}

abstract class SocialMediaFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String link = 'link';
}

class SocialMedia extends Equatable {
  const SocialMedia({
    required this.id,
    required this.name,
    required this.link,
  });

  final int id;
  final Social name;
  final String link;

  static SocialMedia fromJson(JsonMap json) {
    return SocialMedia(
      id: json[SocialMediaFields.id],
      name: json[SocialMediaFields.name],
      link: json[SocialMediaFields.link],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        link,
      ];
}
