import 'package:flutter/material.dart';
import 'package:login_screen_homework/ui/home/home_screen.dart';
import 'package:login_screen_homework/ui/location/location.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationAccess(),
    );
  }
}