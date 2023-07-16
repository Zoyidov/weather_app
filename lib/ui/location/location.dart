import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:login_screen_homework/ui/home/home_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/main/lat_lon.dart';

class LocationAccess extends StatefulWidget {
  const LocationAccess({super.key});

  @override
  State<LocationAccess> createState() => _LocationAccessState();
}

class _LocationAccessState extends State<LocationAccess> {
  LatLong? latLong;

  Future<void> _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      latLong = LatLong(
        lat: locationData.latitude!,
        long: locationData.longitude!,
      );
    });
  }

  _init() async {
    await _getLocation();

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Color(0xFF6223B4),
        highlightColor: Colors.white,
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFF6223B4),
          )
        ),
      ),
    );
  }

}