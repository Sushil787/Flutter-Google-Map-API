import 'package:flutter/material.dart';
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(27.844559, 82.675767), zoom: 15);

  final List<Marker> _list = [];
  final List<Marker> _list1 = [
    const Marker(
      markerId: MarkerId('001'),
      position: LatLng(27.844559, 82.675767),
      infoWindow: InfoWindow(title: "Sushil Home"),
    ),
    const Marker(
      markerId: MarkerId('003'),
      position: LatLng(27.843800, 82.674715),
      infoWindow: InfoWindow(title: "pipari"),
    ),
    const Marker(
      markerId: MarkerId('002'),
      position: LatLng(27.839582, 82.757867),
      infoWindow: InfoWindow(title: "Bhaluwang"),
    )
  ];
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  late Position pos;

  @override
  void initState() {
    _list.addAll(_list1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          markers: Set<Marker>.of(_list1),
          initialCameraPosition: _cameraPosition,
          onMapCreated: (controller) => _controller.complete(controller),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            pos = await _determinePosition();
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(pos.latitude, pos.longitude),
                zoom: 15,
              ),
            ));
            _list1.add(
              Marker(
                  markerId: const MarkerId('00121'),
                  position: LatLng(pos.latitude, pos.longitude),
                  infoWindow:
                      const InfoWindow(title: "Sushil Current Location")),
            );

            setState(() {});
          },
          // onPressed: () async {
          //   GoogleMapController controller = await _controller.future;
          //   controller.animateCamera(CameraUpdate.newCameraPosition(
          //       const CameraPosition(
          //           target: LatLng(27.839582, 82.757867), zoom: 15)));
          //   setState(() {});
          // },
          child: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
