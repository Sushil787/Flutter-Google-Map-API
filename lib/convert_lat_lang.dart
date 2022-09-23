import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

class ConvertLatLngToAdress extends StatefulWidget {
  const ConvertLatLngToAdress({super.key});

  @override
  State<ConvertLatLngToAdress> createState() => _ConvertLatLngToAdressState();
}

class _ConvertLatLngToAdressState extends State<ConvertLatLngToAdress> {
  String addressValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("'Google Maps"),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(addressValue),
            GestureDetector(
              onTap: () async {
                final coordinates = Coordinates(28.3949, 84.1240);
                var address = await Geocoder.local
                    .findAddressesFromCoordinates(coordinates);
                var first = address.first.addressLine.toString() +
                    address.first.countryName.toString();
                setState(() {
                  addressValue = first;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text("convert"),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
