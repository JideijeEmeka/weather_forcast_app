import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:task_weather_app/controller.dart';
import 'package:task_weather_app/loader.dart';
import 'package:task_weather_app/next_7_days_view.dart';
import 'package:task_weather_app/weather_widget.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends StateMVC<HomeView> {
  _HomeViewState() : super(WeatherController()) {
    con = controller as WeatherController;
  }

  late WeatherController con;

  bool changeTodayTextColor = false;
  bool changeTomorrowTextColor = false;
  bool changeNext7DaysTextColor = false;

  Color btnColor = Colors.grey.shade300;
  DateTime todayDate = DateTime.now();

  bool isLoading = false;
  LocationData? _locationData;
  final Location _location = Location();

  Map<String, dynamic> weather = {};

  getWeatherDetails(String latitude, String longitude) async {
    String url = 'https://api.openweathermap.org/data/2.5/forecast?'
        'lat=$latitude&lon=$longitude&appid=ed760b82998d2740aaf34512a60a70c9';
    setState(() {
      isLoading = true;
    });
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        weather = jsonData;
        print(weather);
        isLoading = false;
      });
    }else{
      print('Error Somewhere');
    }
  }

  Future<void> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if(!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    final _currentPosition = await _location.getLocation();
    setState(() {
      _locationData = _currentPosition;
    });
  }

  Map<String, dynamic> icons = {};

  IconData getIconData(int iconPoint) {
    return IconData(iconPoint,
        fontFamily: 'MaterialIcons');
  }

  @override
  void initState() {
    super.initState();
    getLocation().then((_) => {
      getWeatherDetails(_locationData!.latitude.toString(),
          _locationData!.longitude.toString())
    });
  }

  @override
  Widget build(BuildContext context) {

    ///Date Format
    String formattedDate =
    DateFormat("EEE, dd MMM").format(todayDate);
    String formattedTime =
    DateFormat("k:mm a").format(todayDate);

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.menu, color: Colors.white,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('London,', style: TextStyle(color: Colors.white,
                      fontSize: 30, fontWeight: FontWeight.w500),),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text('United Kingdom', style: TextStyle(color: Colors.white,
                        fontSize: 30, fontWeight: FontWeight.w500),),
                  ),
                  Text(formattedDate,
                    style: const TextStyle(color: Colors.white,
                      fontSize: 15),),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Today',
                            style: TextStyle(color: Colors.white,
                            fontSize: 30, fontWeight: FontWeight.w500)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              weather.isNotEmpty ? weather['list'][0]['main']['humidity'] >= 65 ?
                              const FaIcon(FontAwesomeIcons.sun,
                                color: Colors.yellow, size: 80,) :
                              weather['list'][0]['main']['humidity'] <= 40 ?
                              const FaIcon(FontAwesomeIcons.cloudBolt,
                                color: Colors.lightBlue, size: 80,) :
                              const FaIcon(FontAwesomeIcons.cloudShowersHeavy,
                                color: Colors.lightBlue, size: 80,) : Container(),
                              weather.isNotEmpty ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(weather['list'][0]['main']['humidity'].toString() + '°',
                                    style: const TextStyle(color: Colors.white,
                                        fontSize: 50, fontWeight: FontWeight.w500)),
                              ) : Center(
                                child: isLoading ? const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: CircularProgressIndicator
                                    (color: Colors.white,),
                                )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        const Text('Sunny', style: TextStyle(color: Colors.white,
                            fontSize: 20),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () {
                          setState(() {
                            changeTodayTextColor = true;
                            changeTomorrowTextColor = false;
                            changeNext7DaysTextColor = false;
                          });
                        },
                            child: Text('Today', style: TextStyle(color:
                            changeTodayTextColor == true ? Colors.white : btnColor,
                                fontSize: 20),),),
                         TextButton(onPressed: () {
                           setState(() {
                             changeTodayTextColor = false;
                             changeTomorrowTextColor = true;
                             changeNext7DaysTextColor = false;
                           });
                         },
                             child: Text('Tomorrow', style: TextStyle(color:
                             changeTomorrowTextColor == true ? Colors.white :
                             btnColor,
                                 fontSize: 20),),),
                        InkWell(
                          onTap: () {
                            setState(() {
                              changeTodayTextColor = false;
                              changeTomorrowTextColor = false;
                              changeNext7DaysTextColor = true;
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) =>
                                Next7DaysView(weather: weather,
                                    loading: isLoading)));
                          },
                          child: Row(
                            children: [
                              Text('Next 7 Days', style: TextStyle(color:
                              changeNext7DaysTextColor == true ? Colors.white :
                              btnColor,
                                  fontSize: 20),),
                              Icon(Icons.arrow_right_alt_outlined, color:
                              changeNext7DaysTextColor == true ? Colors.white :
                              btnColor,
                                size: 30,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 60, left: 25),
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))
              ),
              child: ListView(
                 // shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: weather.isNotEmpty ? weatherWidget(time: formattedTime,
                        degrees: weather['list'][0]['main']['humidity'].toString() + '°')
                : Center(child: isLoading ?
                loader() : Container(),),
                  ),
                 weather.isNotEmpty ? weatherWidget(time: formattedTime,
                      degrees: weather['list'][1]['main']['humidity'].toString() + '°')
                  : Center(child: isLoading ?
                 loader() : Container()),
                  weather.isNotEmpty ? weatherWidget(time: formattedTime,
                      degrees: weather['list'][2]['main']['humidity'].toString() + '°')
                  : Center(child: isLoading ?
                  loader() : Container()),
                  weather.isNotEmpty ? weatherWidget(time: formattedTime,
                      degrees: weather['list'][3]['main']['humidity'].toString() + '°')
                  : Center(child: isLoading ?
                  loader() : Container(),),
                  weather.isNotEmpty ? weatherWidget(time: formattedTime,
                      degrees: weather['list'][4]['main']['humidity'].toString() + '°')
                  : Center(child: isLoading ?
                  loader() : Container(),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
