import 'package:flutter/material.dart';
import 'package:login_screen_homework/ui/show_modal_bottom_view/widget/daily_cantainer.dart';


class DailyWeatherScreen extends StatelessWidget {
  DailyWeatherScreen({Key? key, required this.lat, required this.lon})
      : super(key: key);
  double lat;
  double lon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                        Text(
                          'Weakley Weather Forecast',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      SizedBox(height: 10),
                      DailyWeather(lat: lat, lon: lon),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
