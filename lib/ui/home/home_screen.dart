import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_screen_homework/ui/home/widgets/remain_weather.dart';
import 'package:login_screen_homework/ui/home/widgets/weather_container.dart';
import 'package:login_screen_homework/utils/images.dart';

import '../../data/models/universal_data.dart';
import '../../data/network/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UniversalData? weatherData;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await WeatherProvider.getMainWeatherDataByLatLong(
      lat: 41.2646,
      lon: 69.2163,
    );

    setState(() {
      weatherData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Scaffold(
        backgroundColor: Color(0xFF833CDF),
        body: Center(
          child: CupertinoActivityIndicator(
            color: Colors.white,
            radius: 20,
          ),
        ),
      );
    } else if (weatherData!.error.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${weatherData!.error}'),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color(0xFF833CDF),
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppImages.background, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: Text(
                      "Locations",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          fontFamily: 'IsonormD',
                          color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(AppImages.search),
                        onPressed: () {},
                      ),
                      PopupMenuButton<String>(
                        color: Color(0xFF6223B4),
                          icon: SvgPicture.asset(AppImages.more),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                onTap: () {},
                                child: Text('Map',style: TextStyle(color: Colors.white),),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {},
                                child: Text('My Location',style: TextStyle(color: Colors.white),),
                              )
                            ];
                          })
                      // Icon(Icons.more_vert, color: Colors.white, size: 35)
                    ],
                  ),
                ),
                Positioned(
                  top: 119,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.location),
                          SizedBox(width: 12),
                          Text(
                            weatherData?.data?.name ?? 'Not found',
                            style: TextStyle(
                                fontFamily: 'IsonormD',
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                (weatherData?.data?.dt ?? 0) * 1000)
                            .toString(),
                        style: TextStyle(
                          fontFamily: 'InriaSerif',
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 97,
                  child: Row(
                    children: [
                      // Lottie.asset(
                      //   AppImages.clouds,
                      // ),
                      SvgPicture.asset(AppImages.cloud),
                      Text(
                        '\t${(weatherData?.data?.temperature ?? 0).toInt()}°',
                        style: TextStyle(
                          fontFamily: 'bitstream',
                          fontSize: 56,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 330,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        '${(weatherData?.data?.minTemperature ?? 0).toInt()}°/${(weatherData?.data?.maxTemperature ?? 0).toInt()}° Feels like ${(weatherData?.data?.feelsLikeTemperature ?? 0).toInt()}°',
                        style: TextStyle(
                          fontFamily: 'bitstream',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        (weatherData?.data?.weather.first.description ?? '')
                            .toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'bitstream',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 400,
                  left: 31,
                  right: 31,
                  child: WeatherContainer(),
                ),
                Positioned(
                  top: 260,
                  child: SvgPicture.asset(
                    AppImages.line,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 650,
                  left: 31,
                  right: 31,
                  child: RemainWeather(
                    image: Image.asset(
                      AppImages.sky,
                      // weatherData?.data?.weather.first.icon ?? '',
                      width: 20,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
