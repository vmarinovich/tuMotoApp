import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DirectionDetails
{
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;
  List<PointLatLng> encodedPoints;

  DirectionDetails({
    this.durationValue,
    this.durationText,
    this.distanceValue,
    this.distanceText,
    this.encodedPoints,});

// ignore: empty_constructor_bodies
}