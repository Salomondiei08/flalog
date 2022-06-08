import 'dart:async';

import 'package:flutter/material.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

import '../db/place.dart';
import '../helpers/distance_beetween.dart';
import '../helpers/marker_data.dart';

const PERMISSION_FILE = "permission.in";

class MarkersProvider extends ChangeNotifier {
  MarkerData? actualPosition;
  MarkerData? pharmacyMarker;

  MarkerData? selectedMarker;
  MarkerData? nearestPlaceMarker;

  Place? nearestPlace;

  late Map places;
  latLng.LatLng? myPosition; //= latLng.LatLng(5.338628, -3.9784693000000004);
  String infoMarker = "Position actuelle";
  bool positionGaranted = false;
  bool inTrackingMode = false;
  // bool inAbidjan = false;
  bool gpsActivated = false;

  List<MarkerData> stops = [];
  List<Marker> stopsMarkers = [];
  List<MarkerData> favorits = [];
  List<Marker> favoritsMarkers = [];
  List<MarkerData> pharmacyMarkers = [];
  //List<Marker> eventsMarkers = [];
  late int nbStops;
  double percentage = 0;
  bool initFinished = false;

  Future<bool> isLocationPermissionAsked() async {
    final directory = await getApplicationDocumentsDirectory();
    return io.File(path.join(directory.path, PERMISSION_FILE)).exists();
  }

  Future<void> setLocationPermission() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = io.File(path.join(directory.path, PERMISSION_FILE));
    file.writeAsString("done");
  }

  Future<void> updateMyPosition() async {
    if (positionGaranted == true) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      myPosition = latLng.LatLng(position.latitude, position.longitude);
      print("position updated ! pos = $myPosition");
    }
  }

  Future<void> _initActualPosition() async {
    bool goForSettings = await isLocationPermissionAsked();
    LocationPermission permission;
    if (!goForSettings) {
      // ask the user to go to the settings for applying the permissions
      permission = await Geolocator.requestPermission();
      await setLocationPermission();
    } else {
      permission = await Geolocator.checkPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      gpsActivated = true;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      myPosition = latLng.LatLng(position.latitude, position.longitude);
      positionGaranted = true;

      Marker marker =  Marker(
          height: 30,
          builder: (context) =>
              MarkerData.getBuilder(MarkerType.myPositionMarker),
          point: myPosition!);
      actualPosition = MarkerData(
          type: MarkerType.myPositionMarker,
          id: "MY_POS",
          name: "Ma Position",
          marker: marker);
      selectedMarker = actualPosition;
      infoMarker = "Position actuelle";
      notifyListeners();
    } else {
      positionGaranted = false;
      gpsActivated = false;
      myPosition = latLng.LatLng(5.338628, -3.9784693000000004);
    }
        
  }

  void updateSelectedMarker(MarkerType type) {
    switch (type) {
      case MarkerType.myPositionMarker:
        selectedMarker = actualPosition;
        infoMarker = "Position actuelle";
        break;

      case MarkerType.pharmacyMarker:
        selectedMarker = pharmacyMarker;
        infoMarker = "Pharmacy choisie";
        break;

      case MarkerType.favotitePlaceMarker:
        if (nearestPlace == null) {
          selectedMarker = favorits[favorits.length - 1];
          infoMarker = selectedMarker!.name;
        } else {
          selectedMarker = nearestPlaceMarker;
          infoMarker = nearestPlace!.name;
          print("nearest place : ${nearestPlace!.name}");
        }
        break;
    }

    notifyListeners();
  }

  Future<void> _initFavMarkers() async {
    List<Place> favPlaces = await PlacesHandler().getPlaces();
    for (var element in favPlaces) {
      places[element.name] = latLng.LatLng(element.lat, element.lon);
      // now create a marker
      Marker marker = Marker(
          width: 3.0,
          height: 3.0,
          point: latLng.LatLng(element.lat, element.lon),
          builder: (ctx) =>
              MarkerData.getBuilder(MarkerType.favotitePlaceMarker));
      favoritsMarkers.add(marker);
      favorits.add(MarkerData(
          type: MarkerType.favotitePlaceMarker,
          id: "FAV", //all the favorites have the same id
          name: element.name,
          marker: marker));
    }

    notifyListeners();
  }

  // Future<void> _initPharmacyMarkers() async {
  //   places = new Map<String, latLng.LatLng>();
  //   List<Stop> listStops = await StopHandler().getStops();
  //   nbStops = listStops.length;
  //   for (var element in listStops) {
  //     // add the stop in the list of places
  //     places[element.name] = latLng.LatLng(element.lat, element.lon);
  //     // now create a marker
  //     Marker marker =  Marker(
  //         width: 3.0,
  //         height: 3.0,
  //         point: latLng.LatLng(element.lat, element.lon),
  //         builder: (ctx) => MarkerData.getBuilder(MarkerType.pharmacyMarker));
  //     stopsMarkers.add(marker);
  //     stops.add(MarkerData(
  //         type: MarkerType.pharmacyMarker,
  //         id: element.id,
  //         name: element.name,
  //         marker: marker));
  //     percentage += 1 / (nbStops * 2);
  //     notifyListeners();
  //   }
  // }

  List<String> getPlaces() {
    return places.keys.toList(growable: false) as List<String>;
  }

  void addPlace(String name, latLng.LatLng pos) {
    places[name] = pos;
    notifyListeners();
  }

  void _updateMarker(MarkerType type, latLng.LatLng pos) {
    MarkerData data = new MarkerData(
        type: type,
        id: "",
        name: "",
        marker: Marker(
            width: 3.0,
            height: 3.0,
            point: pos,
            builder: (ctd) => MarkerData.getBuilder(type)));

    switch (type) {
      case MarkerType.myPositionMarker:
        actualPosition = data;
        break;
      case MarkerType.pharmacyMarker:
        pharmacyMarker = data;
        break;
      case MarkerType.favotitePlaceMarker:
        // selectedStart = data;
        break;
    }
    notifyListeners();
  }

  void _deleteMarker(MarkerType type) {
    switch (type) {
      case MarkerType.myPositionMarker:
        actualPosition = null;
        break;
      case MarkerType.pharmacyMarker:
        pharmacyMarker = null;
        break;
      case MarkerType.favotitePlaceMarker:
        // favorits = null;
        break;
    }
    notifyListeners();
  }

  Place? findNearestFavorit(latLng.LatLng from, double precision) {
    if (favorits.isEmpty) return null;
    double min = distanceBetweenPos(from.longitude, from.latitude,
        favorits[0].marker.point.longitude, favorits[0].marker.point.latitude);
    int idxMin = 0;
    for (int i = 1; i < favorits.length; i++) {
      double dist = distanceBetweenPos(
          from.longitude,
          from.latitude,
          favorits[i].marker.point.longitude,
          favorits[i].marker.point.latitude);
      if (dist < min) {
        idxMin = i;
        min = dist;
      }
    }

    if (min <= precision) {
      nearestPlace = Place(
          name: favorits[idxMin].name,
          lon: favorits[idxMin].marker.point.longitude,
          lat: favorits[idxMin].marker.point.latitude);
      nearestPlaceMarker = favorits[idxMin];
    } else {
      nearestPlace = null;
    }
    notifyListeners();
    return nearestPlace!;
  }

  Future<void> initMarkers() async {
    // await _initPharmacyMarkers();
    await _initFavMarkers();
    await _initActualPosition();
    initFinished = true;
    print("initFinished !!! ");
  }

  void updateActualPosition(latLng.LatLng pos) {
    _updateMarker(MarkerType.myPositionMarker, pos);
  }

  void deleteActualPosition() {
    _deleteMarker(MarkerType.myPositionMarker);
  }
}
