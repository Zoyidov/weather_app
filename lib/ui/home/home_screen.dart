import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_screen_homework/ui/home/widgets/remain_weather.dart';
import 'package:login_screen_homework/ui/home/widgets/search_field.dart';
import 'package:login_screen_homework/ui/home/widgets/weather_container.dart';
import 'package:login_screen_homework/utils/images.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/models/main/lat_lon.dart';
import '../../data/models/universal_data.dart';
import '../../data/network/weather_provider.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key, required this.latLong,}) : super(key: key);

   final LatLong latLong;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UniversalData? weatherData;
  bool isSearchClicked = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await WeatherProvider.getMainWeatherDataByLatLong(
        lon : widget.latLong.long,
        lat : widget.latLong.lat,
    );

    setState(() {
      weatherData = response;
    });
  }

  Future<void> searchCity(String cityName) async {
    final response = await WeatherProvider.getMainWeatherDataByQuery(query: cityName);

    setState(() {
      weatherData = response as UniversalData?;
      isSearchClicked = false;
    });
  }


  void toggleSearchClicked() {
    setState(() {
      isSearchClicked = !isSearchClicked;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF6223B4),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 300),
              Text(
                "Fetching Weather data...",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 50),
              CupertinoActivityIndicator(
                color: Colors.white,
                radius: 20,
              ),
            ],
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
        backgroundColor: const Color(0xFF6223B4),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(AppImages.background, fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
                  Center(
                    child: isSearchClicked
                        ? Padding(
                      padding: const EdgeInsets.only(
                          right: 40, left: 15, top: 62),
                      child: Row(
                        children: [
                          ZoomTapAnimation(
                          onTap: toggleSearchClicked,
                          child: const Icon(Icons.arrow_back_ios,color: Colors.white)),
                          Expanded(
                            child: SearchField(
                              hintText: 'Search',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              onSearch: searchCity,
                            ),
                          ),
                        ],
                      ),
                    )
                        : const Padding(
                      padding: EdgeInsets.only(top: 60),
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
                        if (!isSearchClicked)
                          IconButton(
                            icon: SvgPicture.asset(AppImages.search),
                            onPressed: toggleSearchClicked,
                          ),
                        PopupMenuButton<String>(
                          color: const Color(0xFF6223B4),
                          icon: SvgPicture.asset(AppImages.more),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                onTap: () {},
                                child: const Text(
                                  'Map',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              PopupMenuItem<String>(
                                onTap: () {},
                                child: const Text(
                                  'My Location',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ];
                          },
                        ),
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
                            ZoomTapAnimation(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                    actions: <Widget>[
                                      Lottie.asset(AppImages.maps),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Color(0xFF6223B4)),
                                      ),
                                    ),
                                  ),
                                ).then((value) {
                                  if (value != null &&
                                      value is String &&
                                      value == 'selected') {}
                                });
                              },
                              child: SvgPicture.asset(AppImages.location),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              weatherData?.data?.name ?? 'Not found',
                              style: const TextStyle(
                                  fontFamily: 'IsonormD',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                              (weatherData?.data?.dt ?? 0) * 1000)
                              .toString()
                              .substring(0, 10)
                              .toString(),
                          style: const TextStyle(
                            fontFamily: 'InriaSerif',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 100,
                    child: Row(
                      children: [
                        Image.network(
                          "https://openweathermap.org/img/wn/${weatherData?.data?.weather.first.icon}@2x.png",
                        ),
                        // Lottie.asset(AppImages.cloud,height: 100,width: 100),
                        Text(
                          '${(weatherData?.data?.temperature ?? 0).toInt() - 273}°',
                          style: const TextStyle(
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
                          '${(weatherData?.data?.minTemperature ?? 0).toInt() - 273}°/${(weatherData?.data?.maxTemperature ?? 0).toInt() - 273}° Feels like ${(weatherData?.data?.feelsLikeTemperature ?? 0).toInt() - 273}°',
                          style: const TextStyle(
                            fontFamily: 'bitstream',
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          (weatherData?.data?.weather.first.description ?? '')
                              .toUpperCase(),
                          style: const TextStyle(
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
                    top: 420,
                    left: 31,
                    right: 31,
                    child: WeatherContainer(
                      image: AssetImage(AppImages.map),
                      lat: widget.latLong.lat,
                      lon: widget.latLong.long,
                    )
                  ),
                  Positioned(
                    top: 260,
                    right: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      AppImages.line,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 650,
                    left: 31,
                    right: 31,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          RemainWeather(
                            text: 'RainFall',
                            lottie: Lottie.asset(AppImages.rainfall,height: 60),
                            speed:
                            '${(weatherData?.data?.wind.speed ?? 0).toInt() + 5} sm',
                          ),
                          const SizedBox(height: 20),
                          RemainWeather(
                            text: 'Wind',
                            lottie: Lottie.asset(AppImages.wind,height: 60),
                            speed: '${weatherData?.data?.wind.speed} km/h',
                          ),
                          const SizedBox(height: 20),
                          RemainWeather(
                            text: 'Humidity',
                            lottie: Lottie.asset(AppImages.humidity,height: 60),
                            speed:
                            '${weatherData?.data?.main.humidity} %',
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}