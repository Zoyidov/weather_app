import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_screen_homework/utils/images.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 197,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7730F6).withOpacity(0.83),
            Color(0xFF000000).withOpacity(0.0083),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 29,
            left: 56,
            right: 55,
            height: 180,
            child: Image.asset(
              AppImages.map,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
