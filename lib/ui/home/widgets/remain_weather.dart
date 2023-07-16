import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';


class RemainWeather extends StatefulWidget {
  const RemainWeather({Key? key, required this.text, required this.lottie, required this.speed}) : super(key: key);

  final String text;
  final LottieBuilder lottie;
  final String speed;

  @override
  _RemainWeatherState createState() => _RemainWeatherState();
}

class _RemainWeatherState extends State<RemainWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF000000).withOpacity(0.0083),
            Color(0xFF7730F6).withOpacity(0.83),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: widget.lottie,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Spacer(),
          Text(
            '${widget.speed}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}

