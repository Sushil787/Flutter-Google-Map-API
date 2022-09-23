import 'dart:async';

import 'package:appapiggl/convert_lat_lang.dart';
import 'package:appapiggl/google_map_place_api.dart';
import 'package:appapiggl/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: ImagePickerPractice()));
  }
}
