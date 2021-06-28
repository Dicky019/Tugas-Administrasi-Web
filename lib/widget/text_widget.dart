import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double size;
  final TextOverflow? overflow;
  final Color color;
  const TextWidget({
    required this.size,
    required this.color,
    required this.fontWeight,
    required this.text,
    Key? key,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
      ),
    );
  }
}
