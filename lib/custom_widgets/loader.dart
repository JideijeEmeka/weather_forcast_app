import 'package:flutter/material.dart';

Widget loader() {
  return const Center(child:
  Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: SizedBox(
      height: 20,
        width: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  ),);
}