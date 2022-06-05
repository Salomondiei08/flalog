import 'package:flutter/cupertino.dart';

import '../models/pharmacy.dart';

class PharmacyProvider with ChangeNotifier {
  List<Pharmacy> pharmacyList = [
    Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie les oscars',
        email: 'pharmacie@email.com',
        distanceFromUser: 45,
        lat: 	5.225936,
        long: -3.753666,
        city: 'Bassam'),
         Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie les oscars',
        email: 'pharmacie@email.com',
        distanceFromUser: 90,
        lat: 	5.225936,
        long: -3.753666,
        city: 'Gonzague'),

         Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie les vies',
        email: 'pharmacie@email.com',
        distanceFromUser: 102,
        lat: 	5.225944,
        long: -3.753656,
        city: 'Mockey Ville'),

         Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie lilian',
        email: 'pharmacie@email.com',
        distanceFromUser: 1000,
        lat: 	5.225536,
        long: -3.765666,
        city: '2 Plateaux'),

            Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie les oscars',
        email: 'pharmacie@email.com',
        distanceFromUser: 90,
        lat: 	5.225936,
        long: -3.753666,
        city: 'Gonzague'),

         Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie les vies',
        email: 'pharmacie@email.com',
        distanceFromUser: 102,
        lat: 	5.225944,
        long: -3.753656,
        city: 'Mockey Ville'),

         Pharmacy(
        id: DateTime.now().toString(),
        name: 'Pharmacie lilian',
        email: 'pharmacie@email.com',
        distanceFromUser: 1000,
        lat: 	5.225536,
        long: -3.765666,
        city: '2 Plateaux'),
  ];

  List<Pharmacy> getAll() => [...pharmacyList];

  void addPharmacy(Pharmacy pharmacy) {
    pharmacyList.add(pharmacy);
    notifyListeners();
  }

  void deletePharmacy(Pharmacy pharmacy) {
    pharmacyList.removeWhere((oldPharmacy) => oldPharmacy.id == pharmacy.id);
    notifyListeners();
  }

  List<Pharmacy> findByName(String pharmacyName) {
    return [
      ...pharmacyList.where((oldPharmacy) =>
          oldPharmacy.name.toLowerCase().startsWith(pharmacyName.toUpperCase()))
    ];
  }

  int getLenght() => pharmacyList.length;

  bool isPharmacyListEmpty() => pharmacyList.isEmpty;
}
