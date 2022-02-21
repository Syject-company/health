import 'package:health_plus/extensions/string.dart';

String join(Map<String, List<String>?> errors) {
  final errorMessages = StringBuffer();

  errors.forEach((field, messages) {
    if (messages != null && messages.isNotEmpty) {
      if (field.isEmpty) {
        errorMessages.writeAll(
          messages.map((message) => message.trim().capitalize()),
          '\n',
        );
      } else {
        errorMessages.write('\n$field: ');
        errorMessages.writeAll(
          messages.map((message) => message.trim().capitalize()),
          '\n',
        );
      }
      errorMessages.write('\n');
    }
  });

  return errorMessages.toString().trim();
}
