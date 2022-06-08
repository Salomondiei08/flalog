import 'package:latlong2/latlong.dart' as latlong;

class Pharmacy {
  final String id;
  final String name;
  List<String>? contacts;
  String email;
  final  latlong.LatLng position;
  String? locationText;
  double distanceFromUser;
  var manager;
  final String city;
  bool favourite;
  bool isAllNight;

  Pharmacy({
    required this.id,
    required this.name,
    this.contacts,
    required this.email,
    required this.position,
    this.locationText,
    required this.distanceFromUser,
    this.manager,
    required this.city,
    this.favourite = false,
    this.isAllNight = false,
  });
}
