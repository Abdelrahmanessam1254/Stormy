import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url)); // Use Uri.parse here

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      if (kDebugMode) {
        print('network error ${response.statusCode}');
      }
    }
  }
}
