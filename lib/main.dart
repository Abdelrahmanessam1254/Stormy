import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stormy/screens/loading_screen.dart';
import 'package:stormy/screens/location_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/location': (context) =>  const LocationScreen(),
        // Define other routes if needed
      },
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
