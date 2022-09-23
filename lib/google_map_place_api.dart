// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:http/http.dart' as http;

class GooglePlacesMapApi extends StatefulWidget {
  const GooglePlacesMapApi({super.key});

  @override
  State<GooglePlacesMapApi> createState() => _GooglePlacesMapApiState();
}

class _GooglePlacesMapApiState extends State<GooglePlacesMapApi> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  List<dynamic> _placeList = [];
  String _sessionToken = '12341';
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChanged();
    });
  }

  onChanged() {
    if (_sessionToken == Null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // ignore: constant_identifier_names
    String kPLACESAPIKEY = "AIzaSyBDBlccpWFIwgTKo3GlfkaWJIIWvH0e0B4";
    String request =
        '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      Exception(HttpException);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Google Places Map API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter the Location'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () async {
                      var address = await Geocoder.local.findAddressesFromQuery(
                          '${_placeList[index]["description"]}');
                    },
                    title: Text(_placeList[index]["description"]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
