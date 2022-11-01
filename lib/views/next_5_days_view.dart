import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Next5DaysView extends StatefulWidget {
  final Map weather;
  final bool loading;
  final Future getWeatherForecast;
  const Next5DaysView({Key? key, required this.weather,
    required this.loading, required this.getWeatherForecast}) : super(key: key);

  @override
  State<Next5DaysView> createState() => _Next5DaysViewState();
}

class _Next5DaysViewState extends State<Next5DaysView> {

  @override
  void initState() {
    super.initState();
    // widget.getWeatherForecast;
  }

  @override
  Widget build(BuildContext context) {
    ///Get days of the week
    var days = DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;
    debugPrint(days.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.black
        )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text('Next 5 Days', style: TextStyle(color: Colors.black.withOpacity(0.8),
                    fontSize: 30, fontWeight: FontWeight.w500),),
              ),
              widget.weather.isNotEmpty ?
              ListView.builder(
                    shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: widget.weather.length,
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
                                    widget.weather['list'][i]['main']['humidity'] >= 65 ?
                                    const FaIcon(FontAwesomeIcons.sun,
                                      color: Colors.yellow,) :
                                    widget.weather['list'][i]['main']['humidity'] <= 40 ?
                                    const FaIcon(FontAwesomeIcons.cloudBolt,
                                      color: Colors.lightBlue,) : const FaIcon(FontAwesomeIcons.cloudShowersHeavy,
                                      color: Colors.lightBlue,),
                                    // Icon(
                                    //   getIconData(int.parse('${weather['list'][0]['weather'][0]['icon']}'))
                                    // ),
                                    const SizedBox(width: 50),
                                    Text(widget.weather['list'][i]['main']['humidity'].toString() + '°' , style: const TextStyle(color: Colors.black,
                                        fontSize: 20, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ) :
              Center(
                child: widget.loading ? const Padding(
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
