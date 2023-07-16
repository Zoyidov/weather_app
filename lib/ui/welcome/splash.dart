// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:login_screen_homework/ui/home/home_screen.dart';
//
// import '../../data/models/main/lat_lon.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   LatLong? latLong;
//
//   Future<void> _getLocation() async {
//     Location location = Location();
//
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//     LocationData locationData;
//
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     locationData = await location.getLocation();
//
//     setState(() {
//       latLong = LatLong(
//         lat: locationData.latitude!,
//         long: locationData.longitude!,
//       );
//     });
//   }
//
//   _init() async {
//     await _getLocation();
//
//     await Future.delayed(const Duration(seconds: 1));
//
//     if (context.mounted) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//         return HomePage();
//       }));
//     }
//   }
//
//   @override
//   void initState() {
//     _init();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("${latLong?.long}  and ${latLong?.lat}  "),
//       ),
//     );
//   }
// }