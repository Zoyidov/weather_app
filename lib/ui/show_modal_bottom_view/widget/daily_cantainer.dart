import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/main/weakly_weather_model.dart';


class DailyWeather extends StatefulWidget {
  DailyWeather({Key? key,required this.lat,required this.lon}) : super(key: key);
  double lat;
  double lon;

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  Welcome? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData(widget.lat.toString(),widget.lon.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF6223B4).withOpacity(0.9),
      ),
      child: isLoading
          ? const Center(child: CupertinoActivityIndicator(color: Colors.white,radius: 15,))
          : ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (weatherData?.daily.length ?? 1)-1,
        itemBuilder: (BuildContext context, int index) {
          final dailyWeather = weatherData?.daily[index+1];
          final dayOfWeek = getDayOfWeek(dailyWeather?.dt);
          final temperature = dailyWeather?.temp.day.toInt() ?? '';


          final weatherIconUrl =
              'https://openweathermap.org/img/wn/${dailyWeather?.weather.first.icon}@2x.png';

          return Container(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: [
                Text(
                  dayOfWeek ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$temperature°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                if (dailyWeather?.weather.isNotEmpty ?? false)
                  Image.network(
                    weatherIconUrl,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? getDayOfWeek(int? timestamp) {
    if (timestamp != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return getWeekdayName(dateTime.weekday);
    }
    return null;
  }

  String getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  Future<void> fetchData(
      String lat,
      String lon,
      ) async {
    final url = 'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=hourly,current,minutely&appid=649ff9f2558d2c45135158b30bc262d8';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          weatherData = Welcome.fromJson(jsonData);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
    }
  }
}
