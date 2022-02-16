import 'package:health_plus/typedefs.dart';

abstract class JsonSerializable {
  JsonMap toJson();
}

abstract class MultipartSerializable {
  MultipartMap toMultipart();
}
