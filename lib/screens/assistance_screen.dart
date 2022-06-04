import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theme/app_theme.dart';

class AssistanceScreen extends StatefulWidget {
  const AssistanceScreen({Key? key}) : super(key: key);

  @override
  State<AssistanceScreen> createState() => _AssistanceScreenState();
}

class _AssistanceScreenState extends State<AssistanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "FLALOG'",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: AppTheme.green, fontSize: 33),
                ),
                InkWell(child: CircleAvatar(radius: 20))
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "ASSISTANCE",
              style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 25),
            ),
          ),
           SizedBox(
            height: 5.h,
          ),
          Container(
            height: 45.h,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: [
                  AssistanceItem(
                    text: "Douleurs de ventre",
                    iconData: Icons.bloodtype,
                  ),
                  AssistanceItem(
                    text: "Douleurs de dos",
                    iconData: Icons.bloodtype,
                  ),
                  AssistanceItem(
                    text: "Grippe",
                    iconData: Icons.local_pharmacy,
                  ),
                  AssistanceItem(
                    text: "Douleurs Bénignes",
                    iconData: Icons.bloodtype,
                  ),
                  AssistanceItem(
                    text: "Parler avec un spécialiste",
                    iconData: Icons.chat,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssistanceItem extends StatelessWidget {
  final String text;

  final IconData iconData;

  const AssistanceItem({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: ListTile(
        title: Text(text),
        leading: Icon(
          iconData,
          color: AppTheme.green,
        ),
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: AppTheme.darkGray,
      ),
    );
  }
}
