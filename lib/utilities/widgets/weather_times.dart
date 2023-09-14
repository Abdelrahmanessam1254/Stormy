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
    final isMorning =  widget.time! >= 6 && widget.time! < 15; // 6 AM to 2:59 PM
    final isEvening = widget.time! >= 15 && widget.time! <= 18; // 3 PM to 5:59 PM
    Color backgroundColor;
    if (isMorning) {
      backgroundColor = Colors.white.withOpacity(0.3);
    } else if (isEvening) {
      backgroundColor = Colors.orange.withOpacity(0.55);
    } else {
      backgroundColor = Colors.black;
    }
    return Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(widget.icon,
                  color: Colors.white,
                ),
                const SizedBox(width: 10,),
                Text(
                  widget.text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Fabrica',
                    fontWeight: FontWeight.bold,
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
