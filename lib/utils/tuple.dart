import 'package:equatable/equatable.dart';

class Tuple2<T1, T2> extends Equatable {
  const Tuple2(this.item1, this.item2);

  final T1 item1;
  final T2 item2;

  @override
  List<Object?> get props => [
        item1,
        item2,
      ];

  @override
  String toString() => '[$item1, $item2]';
}
