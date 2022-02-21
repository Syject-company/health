import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Elevation extends StatelessWidget {
  const Elevation({
    Key? key,
    required this.color,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.offset = Offset.zero,
    required this.child,
  }) : super(key: key);

  final Color color;
  final double blurRadius;
  final double spreadRadius;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color,
            offset: offset,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
