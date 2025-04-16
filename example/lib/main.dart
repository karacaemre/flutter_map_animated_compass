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
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(37.7749, -122.4194),
          zoom: 13,
          rotation: 45,
        ),
        children: [
          TileLayer(
            urlTemplate: 'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',
          ),
          Positioned(
            right: 16,
            top: 60, child: Column(children: [
            CompassButton(
              mapController: _mapController,
              size: 60,
            )
          ],),)
        ],
      ),
    );
  }
}
