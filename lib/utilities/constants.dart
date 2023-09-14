import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Fabrica',
  fontSize: 90.0,
);

const kSmallTempTextStyle = TextStyle(
  fontFamily: 'Fabrica',
  fontSize: 30.0,
);

const kColumnText = TextStyle(
    color: Colors.white,
    fontFamily: 'Fabrica',
    fontSize: 18,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Fabrica',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Colors.white
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const textfielddecostyle = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.search,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);
