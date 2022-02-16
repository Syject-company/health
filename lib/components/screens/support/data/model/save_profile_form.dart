import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

abstract class SendMessageFormFields {
  static const String fullName = 'name';
  static const String phoneNumber = 'phone_number';
  static const String type = 'type';
  static const String subject = 'subject';
  static const String description = 'description';
}

class SendMessageForm extends Equatable implements JsonSerializable {
  const SendMessageForm({
    required this.fullName,
    required this.phoneNumber,
    required this.type,
    required this.subject,
    required this.description,
  });

  final String fullName;
  final String phoneNumber;
  final String type;
  final String subject;
  final String description;

  @override
  JsonMap toJson() {
    return {
      SendMessageFormFields.fullName: fullName,
      SendMessageFormFields.phoneNumber: phoneNumber,
      SendMessageFormFields.type: type,
      SendMessageFormFields.subject: subject,
      SendMessageFormFields.description: description,
    };
  }

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        type,
        subject,
        description,
      ];
}
