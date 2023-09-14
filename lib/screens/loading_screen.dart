// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:permission_handler/permission_handler.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    PermissionStatus status = await Permission.location.request();

    if (status.isDenied) {
      // Handle the case where the user denied location permission
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text('Please grant location permission to use this app.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                // You can perform any other action or provide an alternative functionality
              },
            ),
          ],
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // Handle the case where the user denied location permission permanently
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
              'Please enable location permission in app settings to use this app.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                // You can guide the user to enable the permission manually
              },
            ),
          ],
        ),
      );
    } else {
      // Location permission granted or already granted
      var weatherData = await weatherModel.getLocationWeather();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            locationWeather: weatherData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 100.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
