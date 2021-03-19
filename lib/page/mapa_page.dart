import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition initialPoint =
        CameraPosition(target: scan.getLatLng(), zoom: 17.4746, tilt: 50);

    Set<Marker> markets = new Set<Marker>();
    markets.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera((CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: scan.getLatLng(), zoom: 17.5, tilt: 50),
                )));
              })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markets,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }
          setState(() {});
        },
      ),
    );
  }
}
