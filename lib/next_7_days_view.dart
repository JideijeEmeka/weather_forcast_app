import 'dart:convert';
import 'dart:io';
import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Next7DaysView extends StatefulWidget {
  const Next7DaysView({Key? key}) : super(key: key);

  @override
  State<Next7DaysView> createState() => _Next7DaysViewState();
}

class _Next7DaysViewState extends State<Next7DaysView> {

  bool isLoading = false;
  LocationData? _locationData;
  final Location _location = Location();

  Map<String, dynamic> weather = {};

  void getWeatherDetails(String latitude, String longitude) async {
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

    var days = DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;
    print(days);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => Navigator.pop(context),
            color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text('Next 7 Days', style: TextStyle(color: Colors.black.withOpacity(0.8),
                    fontSize: 30, fontWeight: FontWeight.w500),),
              ),
              weather.isNotEmpty ?
              ListView.builder(
                    shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: weather.length,
                      itemBuilder: (context, i) =>
                          Container(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(days[i].toString(), style: TextStyle(color: Colors.black.withOpacity(0.8),
                                    fontSize: 20, fontWeight: FontWeight.w500),),
                                Row(
                                  children: [
                                    const Icon(IconData(0xf518, fontFamily: 'MaterialIcons')),
                                    const SizedBox(width: 30),
                                    Text(weather['list'][i]['main']['humidity'].toString() + '°' , style: const TextStyle(color: Colors.black,
                                        fontSize: 20, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ) :
              Center(
                child: isLoading ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 180),
                  child: Center(child: CircularProgressIndicator()),
                )
                : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
