import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Next7DaysView extends StatefulWidget {
  const Next7DaysView({Key? key}) : super(key: key);

  @override
  State<Next7DaysView> createState() => _Next7DaysViewState();
}

class _Next7DaysViewState extends State<Next7DaysView> {

  Map<String, dynamic> weather = {};

  void getWeatherDetails() async {
    String url = 'https://api.openweathermap.org/data/2.5/forecast?'
        'lat=35&lon=139&appid=ed760b82998d2740aaf34512a60a70c9';
    print('pressed API');
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      print(response.body);
      setState(() {
        weather = jsonDecode(response.body);
      });
    }else{
      print('Error Somewhere');
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherDetails();
  }

  @override
  Widget build(BuildContext context) {
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
          margin: const EdgeInsets.only(left: 20, right: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text('Next 7 Days', style: TextStyle(color: Colors.black.withOpacity(0.8),
                    fontSize: 30, fontWeight: FontWeight.w500),),
              ),
              ListView.builder(
                    shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, i) =>
                          Container(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(weather['cnt'].toString(), style: TextStyle(color: Colors.black.withOpacity(0.8),
                                    fontSize: 20, fontWeight: FontWeight.w500),),
                                Row(
                                  children: const [
                                    Icon(Icons.cloud, size: 30,),
                                    SizedBox(width: 30,),
                                    Text('12°', style: TextStyle(color: Colors.black,
                                        fontSize: 20, fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
