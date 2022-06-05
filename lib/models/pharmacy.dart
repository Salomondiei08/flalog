class Pharmacy {
  final String id;
  final String name;
  List<String>? contacts;
  String email;
  final double lat;
  final double long;
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
    required this.lat,
    required this.long,
    this.locationText,
    required this.distanceFromUser,
    this.manager,
    required this.city,
    this.favourite = false,
    this.isAllNight = false,
  });
}
