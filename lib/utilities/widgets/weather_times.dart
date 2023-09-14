import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherTimes extends StatefulWidget {
  final int? time;
  final String? text;
  final IconData? icon;
  final Widget? widget;
  const WeatherTimes({super.key, this.text, this.icon, this.widget, this.time});

  @override
  State<WeatherTimes> createState() => _WeatherTimesState();
}

class _WeatherTimesState extends State<WeatherTimes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        color: widget.time! > 12 ? Colors.white.withOpacity(0.4) :Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(widget.icon,
                  color: Colors.white
                ),
                const SizedBox(width: 10,),
                Text(
                  widget.text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Fabrica',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.white
            ),
            widget.widget!,
          ],
        ),
      ),
    );
  }
}
