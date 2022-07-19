import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_weather_app/next_7_days_view.dart';
import 'package:task_weather_app/weather_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool changeTodayTextColor = false;
  bool changeTomorrowTextColor = false;
  bool changeNext7DaysTextColor = false;

  Color btnColor = Colors.red;
  DateTime todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    ///Date Format
    String formattedDate =
    DateFormat("EEE, dd MMM").format(todayDate);
    //String formattedSuccessTime = DateFormat("kk:mm").format(todayDate);

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
                            children: const [
                              Icon(Icons.wb_sunny_outlined, size: 80,
                                color: Colors.yellow,),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('22°',
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 50, fontWeight: FontWeight.w500)),
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
                                const Next7DaysView()));
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
                 shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: weatherWidget(time: '9AM', degrees: '16°'),
                  ),
                  weatherWidget(time: '9AM', degrees: '16°'),
                  weatherWidget(time: '9AM', degrees: '16°'),
                  weatherWidget(time: '9AM', degrees: '16°'),
                  weatherWidget(time: '9AM', degrees: '16°')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
