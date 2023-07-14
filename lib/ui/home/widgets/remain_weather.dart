import 'package:flutter/material.dart';

class RemainWeather extends StatelessWidget {
  const RemainWeather({Key? key, required this.image}) : super(key: key);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFF6223B4),
      ),
      child: image,
    );
  }
}
