import 'package:flutter/material.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animated_compass/flutter_map_animated_compass.dart';
import 'dart:async';

import 'package:latlong2/latlong.dart';

// MapController'ı extend edemeyiz, implements yaparız
class DummyMapController implements MapController {
  bool wasRotated = false; // bu alan sadece test içindir

  @override
  bool rotate(double degree, {String? id}) {
    wasRotated = true;
    return true;
  }

  @override
  double get rotation => 45;

  @override
  Stream<MapEvent> get mapEventStream => const Stream.empty();

  @override
  // TODO: implement bounds
  LatLngBounds? get bounds => throw UnimplementedError();

  @override
  // TODO: implement center
  LatLng get center => throw UnimplementedError();

  @override
  CenterZoom centerZoomFitBounds(LatLngBounds bounds, {FitBoundsOptions? options}) {
    // TODO: implement centerZoomFitBounds
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void fitBounds(LatLngBounds bounds, {FitBoundsOptions? options}) {
    // TODO: implement fitBounds
  }

  @override
  CustomPoint<double>? latLngToScreenPoint(LatLng latLng) {
    // TODO: implement latLngToScreenPoint
    throw UnimplementedError();
  }

  @override
  // TODO: implement mapEventSink
  StreamSink<MapEvent> get mapEventSink => throw UnimplementedError();

  @override
  bool move(LatLng center, double zoom, {String? id}) {
    // TODO: implement move
    throw UnimplementedError();
  }

  @override
  MoveAndRotateResult moveAndRotate(LatLng center, double zoom, double degree, {String? id}) {
    // TODO: implement moveAndRotate
    throw UnimplementedError();
  }

  @override
  LatLng? pointToLatLng(CustomPoint<num> point) {
    // TODO: implement pointToLatLng
    throw UnimplementedError();
  }

  @override
  set state(FlutterMapState state) {
    // TODO: implement state
  }

  @override
  // TODO: implement zoom
  double get zoom => throw UnimplementedError();
}

void main() {
  testWidgets('CompassButton renders and reacts to tap', (WidgetTester tester) async {
    final dummyController = DummyMapController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompassButton(mapController: dummyController),
        ),
      ),
    );

    // Widget render edildi mi?
    expect(find.byType(CompassButton), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Tap et
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // rotate çağrıldı mı?
    expect(dummyController.wasRotated, isTrue);
  });
}
