import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:get/get.dart';
import 'dart:core';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  // ignore: library_private_types_in_public_api
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Unfocus text fields when tapping outside of them
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/city.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: Get.height*0.02,),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.2,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: textfielddecostyle,
                        onChanged: (value) {
                          cityname = value;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.locationWeather['name'] == null) {
                          Get.snackbar('Error', 'No such City or Country');
                        }
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context, cityname);
                      },
                      child: const Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
