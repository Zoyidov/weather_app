import 'package:flutter/material.dart';

import '../../utils/images.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6223B4),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(AppImages.background, fit: BoxFit.cover),
            ],
          )
        ],
      ),
    );
  }
}

