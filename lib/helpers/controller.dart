import 'dart:convert';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class WeatherController extends ControllerMVC {

  Map<String, dynamic> weather = {};

  getWeatherDetails(String latitude, String longitude) async {
    String url = 'https://api.openweathermap.org/data/2.5/forecast?'
        'lat=$latitude&lon=$longitude&appid=ed760b82998d2740aaf34512a60a70c9';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
    }else{
      print('Error Somewhere');
    }
  }

  WeatherController();
}