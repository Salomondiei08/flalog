import 'package:flalog/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MarkerType { pharmacyMarker, favotitePlaceMarker, myPositionMarker }

Widget createIconWidget(Color color, double size) {
  return Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
    ),
    child: Center(
      child: Container(height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    )
  );
}

class MarkerData {
  MarkerType type; // type of the marker defined byt the MarkerType enum
  Marker marker; // the marker to be displayed on the map
  String id; // identifier used to link the marker to the database fields
  String name;

  MarkerData(
      {required this.type,
      required this.marker,
      required this.id,
      required this.name});

  static Widget getBuilder(MarkerType type) {
    switch (type) {
      case MarkerType.pharmacyMarker:
        return createIconWidget(AppTheme.green, 16.0);
      case MarkerType.favotitePlaceMarker:
        return createIconWidget(Colors.deepPurple, 22.0);
      case MarkerType.myPositionMarker:
        return createIconWidget(Colors.red, 16.0);
    }
  }
}
