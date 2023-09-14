import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? longitude;
  double? latitude;

  Future<void> getCurrentLocation() async {
    try {
      Position postion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = postion.longitude;
      latitude = postion.latitude;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
