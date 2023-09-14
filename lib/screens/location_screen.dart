// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stormy/utilities/widgets/weather_times.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';
import '../utilities/widgets/compass.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int? temprature;
  int? tempratureMin;
  int? tempratureMax;
  int? feelsLike;
  int? humidity;
  int? pressure;
  int? visibility;
  double? degree;
  double? speed;
  String? weatherIcon;
  String? cityName;
  String? countryName;
  String? weatherText;
  String? feelsLikeText;

  var time = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temprature = 0;
        tempratureMin = 0;
        tempratureMax = 0;
        feelsLike = 0;
        humidity = 0;
        pressure = 0;
        visibility = 0;
        degree = 0;
        speed = 0;
        weatherIcon = 'Error';
        weatherText = 'Unable to get Weather data';
        cityName = '';
        countryName = 'No such Country\n or city';
        return;
      }
      if (weatherdata != null) {
        double temp = weatherdata['main']['temp'].toDouble();
        double tempMin = weatherdata['main']['temp_min'].toDouble();
        double tempMax = weatherdata['main']['temp_max'].toDouble();
        double feel = weatherdata['main']['feels_like'].toDouble();
        double hum = weatherdata['main']['humidity'].toDouble();
        double pre = weatherdata['main']['pressure'].toDouble();
        double vis = weatherdata['visibility'].toDouble();
        double deg = weatherdata['wind']['deg'].toDouble();
        double spe = weatherdata['wind']['speed'].toDouble();
        if (kDebugMode) {
          print(temp);
        }
        temprature = temp.toInt();
        tempratureMin = tempMin.toInt();
        tempratureMax = tempMax.toInt();
        feelsLike = feel.toInt();
        humidity = hum.toInt();
        pressure = pre.toInt();
        visibility = vis.toInt();
        degree = deg;
        speed = spe;
      } else {
        // Handle the case where the data is missing or not in the expected format
        temprature = 0;
        tempratureMin = 0;
        tempratureMax = 0;
        feelsLike = 0;
        humidity = 0;
        pressure = 0;
        visibility = 0;
        degree = 0.0;
        speed = 0.0;
      }
      var condition = weatherdata['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherdata['name'];
      countryName = weatherdata['sys']['country'];
      weatherText = weatherModel.getWeatherMessage(temprature!);
      feelsLikeText = weatherModel.getFeelsLikeMessage(feelsLike!, temprature!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var fomatedTime = DateFormat('hh').format(time);
    int finalTime = int.tryParse(fomatedTime) ?? 0;
    double dewPoint = temprature! - ((100 - humidity!) / 5);
    if (kDebugMode) {
      print(finalTime);
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: finalTime > 12
                ? const AssetImage('images/morning.jpg')
                : const AssetImage('images/night.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: ListView(children: [
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: finalTime > 12 ? Colors.white60 : Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedcity = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CityScreen(locationWeather: widget.locationWeather!,);
                          }),
                        );
                        if (typedcity != null) {
                          var weatherdata =
                              await weatherModel.getCityWeather(typedcity);
                          updateUI(weatherdata);
                        }
                      },
                      child: Icon(
                        Icons.search,
                        size: 50.0,
                        color: finalTime > 12 ? Colors.white60 : Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$cityName",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        '$countryName',
                        style: kSmallTempTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Text(
                  "$weatherText",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Spartan MB',
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'H:$tempratureMax°',
                      style: kSmallTempTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'L:$tempratureMin°',
                      style: kSmallTempTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: WeatherTimes(
                        time: finalTime,
                        text: 'Feels Like',
                        icon: Icons.water_drop,
                        widget: Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              '$feelsLike°',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 50,
                                fontFamily: "Fabrica",
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              feelsLikeText!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "Fabrica",
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: WeatherTimes(
                        time: finalTime,
                        text: 'Wind',
                        icon: CupertinoIcons.wind,
                        widget: Column(
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              '$speed km/h',
                              // Display the degree value as text
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Fabrica'),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Compass(
                              degree: degree!,
                              time: finalTime,
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: WeatherTimes(
                        time: finalTime,
                        text: 'Humidity',
                        icon: Icons.water,
                        widget: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '$humidity%',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 45,
                                fontFamily: "Fabrica",
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              'The dew point is ${dewPoint.toStringAsFixed(0)} right now.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Fabrica",
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: WeatherTimes(
                        time: finalTime,
                        text: 'Pressure',
                        icon: CupertinoIcons.rectangle_compress_vertical,
                        widget: Column(
                          children: [
                            Stack(children: [
                              const Image(
                                image: AssetImage('images/scale.png'),
                                color: Colors.white,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 42,
                                left: 44,
                                child: Text(
                                  '=\n$pressure\nhPa',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Fabrica",
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Positioned(
                                top: 135,
                                left: 35,
                                child: Text(
                                  'Low',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Fabrica",
                                      color: Colors.white,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Positioned(
                                top: 135,
                                right: 35,
                                child: Text(
                                  'High',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Fabrica",
                                      color: Colors.white,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ]),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: WeatherTimes(
                        time: finalTime,
                        text: 'Visibility',
                        icon: Icons.remove_red_eye,
                        widget: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              '${visibility! / 1000} km',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontFamily: "Fabrica"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            visibility! / 1000 > 5
                                ? const Text(
                                    'It\'s perfectly clear right now.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "Fabrica"),
                                  )
                                : const Text(
                                    'It\'s not clear right now.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "Fabrica"),
                                  ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
