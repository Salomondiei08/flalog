import 'package:flutter/material.dart';

import '../models/pharmacy.dart';
import '../theme/app_theme.dart';

class PharmacyItem extends StatelessWidget {
  const PharmacyItem({
    Key? key, required this.pharmacyList,
  }) : super(key: key);

  final List<Pharmacy> pharmacyList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pharmacie des parles",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppTheme.green, fontWeight: FontWeight.bold),
                ),
                Text(
                  "120 m",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            Text(
              "Carrefour Bateau",
            )
          ],
        ),
      ),
      separatorBuilder: (_, i) => Divider(color: Colors.grey),
      itemCount: 10,
    );
  }
}
