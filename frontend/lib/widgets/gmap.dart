import 'package:flutter/material.dart';
import 'package:frontend/env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class GMap extends StatefulWidget {
  final List<double> coordinates;
  const GMap( {Key? key, required this.coordinates}): super(key: key);

  @override
  State<GMap> createState() => GMapState();
}

class GMapState extends State<GMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  
  

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {
    final x = widget.coordinates[0];
    final y = widget.coordinates[1];
    final z = widget.coordinates[2];
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ClipRRect(
            borderRadius:  const BorderRadius.all(Radius.circular(ROUNDED_CORNER_GLOBAL)),
            child: GoogleMap(
              
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(x,y),
                zoom: z,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
