import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animated_compass/flutter_map_animated_compass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapExample extends StatefulWidget {
  const MapExample({super.key});

  @override
  State<MapExample> createState() => _MapExampleState();
}

class _MapExampleState extends State<MapExample> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                maxZoom: 21.0,
                minZoom: 3.0,
                center: LatLng(36.884804, 30.704044),
                zoom: 13,
              ),
              children: [
                TileLayer(
                  maxZoom: 21,
                  urlTemplate:
                  "http://{s}.google.com/vt/lyrs=r&x={x}&y={y}&z={z}",
                  subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                  additionalOptions: const {
                    'layers': 'streets',
                  },
                ),

              ]),
          Positioned(
              right: 16,
              top: 60,
              child: CompassButton(
                mapController: _mapController,
              )),
        ],
      ),
    );
  }
}
