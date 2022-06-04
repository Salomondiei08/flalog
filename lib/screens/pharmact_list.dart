import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theme/app_theme.dart';
import '../widgets/pharmacy_item.dart';
import '../widgets/search_widget.dart';

class PharmacyList extends StatefulWidget {
  const PharmacyList({Key? key}) : super(key: key);

  @override
  State<PharmacyList> createState() => _PharmacyListState();
}

class _PharmacyListState extends State<PharmacyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FLALOG'",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: AppTheme.green, fontSize: 33),
                  ),
                  SizedBox(height: 2.h),
                  const SizedBox(width: double.infinity),
                  SizedBox(
                    height: 8.h,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 65.w,
                          child: SearchWidget(
                            context: context,
                            isPlaceMode: false,
                          ),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Container(
                          height: 7.h,
                          width: 7.h,
                          decoration: BoxDecoration(
                            color: AppTheme.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 3,
            child: PharmacyItem(pharmacyList: []),
          )
        ],
      ),
    );
  }
}
