import 'package:flutter/material.dart';

Widget weatherWidget({required String time, required Widget icon,
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: icon,
        ),
        Text(degrees, style: const TextStyle(color: Colors.white,
            fontSize: 20),),
      ],
    ),
  );
}