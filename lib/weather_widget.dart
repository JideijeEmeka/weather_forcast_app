import 'package:flutter/material.dart';

Widget weatherWidget({required String time,
required String degrees}) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(35)
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    margin: const EdgeInsets.only(
        right: 20, top: 30, bottom: 30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(time, style: const TextStyle(color: Colors.white,
            fontSize: 15),),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Icon(Icons.cloud, color: Colors.white,
            size: 30,),
        ),
        Text(degrees, style: const TextStyle(color: Colors.white,
            fontSize: 20),),
      ],
    ),
  );
}