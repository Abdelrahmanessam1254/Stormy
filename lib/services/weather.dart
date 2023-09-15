import 'package:flutter/foundation.dart';

import 'location.dart';
import 'networking.dart';
const apiKey = '';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityname) async {
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherURL?q=$cityname&appid=$apiKey&units=metric');
    try{
      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch(e){
      if (kDebugMode) {
        print('error is $e');
      }
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherdata = await networkhelper.getData();

    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String? getWeatherMessage(int temp) {
    if (temp > 26) {
      return 'Too Hot Today';
    } else if (temp >= 18 && temp <= 26) {
      return 'A little Warm Today';
    } else if (temp <= 18) {
      return 'Freezy...';
    } else if (temp <= 10) {
      return 'So Cold..';
    }
    return null;
  }

  String? getFeelsLikeMessage(int feelsLike,int temp) {
    if (feelsLike > temp) {
      return 'Humidity is making it feel warmer.';
    } else if (feelsLike < temp) {
      return 'Wind is making it feel cooler.';
    } else if(feelsLike == temp){
      return 'Similar to the actual temprature.';
    }
    return null;
  }
}
