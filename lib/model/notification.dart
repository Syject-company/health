import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

export 'plan_price.dart';

abstract class NotificationFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String body = 'body';
  static const String sentDate = 'sentDate';
}

class Notification extends Equatable with JsonSerializable {
  const Notification({
    required this.id,
    this.title,
    this.body,
    this.sentDate,
  });

  final int id;
  final String? title;
  final String? body;
  final DateTime? sentDate;

  @override
  JsonMap toJson() {
    return {
      NotificationFields.id: id,
      NotificationFields.title: title,
      NotificationFields.body: body,
      NotificationFields.sentDate: sentDate?.toIso8601String(),
    };
  }

  static Notification fromJson(JsonMap json) {
    DateTime? sentDate;
    if (json[NotificationFields.sentDate] != null) {
      sentDate = DateTime.parse(json[NotificationFields.sentDate]);
    }

    return Notification(
      id: json[NotificationFields.id],
      title: json[NotificationFields.title],
      body: json[NotificationFields.body],
      sentDate: sentDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        sentDate,
      ];
}
