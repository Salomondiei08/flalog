import 'package:flalog/screens/search_pharmacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../theme/app_icon_icons.dart';
import '../theme/app_theme.dart';
import '../widgets/search_widget.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding:  EdgeInsets.only(top: 5.h, left: 5.w, right:  5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "FLALOG'",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: AppTheme.green, fontSize: 33),
                        ),
                        Icon(AppIcon.pill)
                      ],
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
                              padding:  EdgeInsets.all(10),
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
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, index) => InkWell(
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              'La vie est belle',
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: index == indexSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: index == indexSelected
                                ? AppTheme.green
                                : AppTheme.gray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )),
            ),
          ),
          Expanded(
            flex: 8,
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return Container(
                  height: 100 * index / 2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      'La vie est belle',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: index == indexSelected
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color:
                        index == indexSelected ? AppTheme.green : AppTheme.gray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

void _showSearchScreen(BuildContext context) {

 showSearch(context: context, delegate: SearchPharmacyScreen());
}