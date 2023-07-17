import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../show_modal_bottom_view/show_modal_bottom_view.dart';

class WeatherContainer extends StatelessWidget {
  WeatherContainer({Key? key, this.image,required this.lon,required this.lat}) : super(key: key);
  double lat;
  double lon;

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF7730F6).withOpacity(0.83),
            const Color(0xFF000000).withOpacity(0.0083),
          ],
        ),
      ),
      child: ZoomTapAnimation(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            clipBehavior: Clip.hardEdge,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return DailyWeatherScreen(lat: lat, lon: lon,);
            },
          );
        },
        child: image != null
            ? Image(image: image!, fit: BoxFit.contain)
            : const SizedBox(), // Placeholder widget if image is not provided
      ),
    );
  }
}
