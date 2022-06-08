import 'package:flalog/screens/map_screen.dart';
import 'package:flutter/material.dart';

import '../models/pharmacy.dart';
import '../theme/app_theme.dart';

class PharmacyItem extends StatelessWidget {
  const PharmacyItem({
    Key? key,
    required this.pharmacyList,
  }) : super(key: key);

  final List<Pharmacy> pharmacyList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapScreen(
              selectedPharmacy: pharmacyList[i],
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pharmacyList[i].name,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppTheme.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${pharmacyList[i].distanceFromUser} m",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
              Text(
                pharmacyList[i].city,
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (_, i) => const Divider(color: Colors.grey),
      itemCount: pharmacyList.length,
    );
  }
}
