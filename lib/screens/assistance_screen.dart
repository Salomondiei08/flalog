import 'package:flalog/theme/app_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../helpers/authservice.dart';
import '../theme/app_theme.dart';
import 'chat/rooms.dart';
import 'login_screen.dart';

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
                InkWell(
                  onTap: () {
                    AuthService().signOut();
                  },
                  child: googleUser?.photoURL != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(googleUser!.photoURL!),
                        )
                      : const Icon(
                          Icons.person,
                        ),
                )
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
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 25),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 45.h,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: [
                  AssistanceItem(
                    text: "Douleurs de ventre",
                    iconData: AppIcon.stomach,
                  ),
                  AssistanceItem(
                    text: "Douleurs de dos",
                    iconData: Icons.bloodtype,
                  ),
                  AssistanceItem(
                    text: "Grippe",
                    iconData: AppIcon.throat,
                  ),
                  AssistanceItem(
                    text: "Douleurs Bénignes",
                    iconData: Icons.bloodtype,
                  ),
                  AssistanceItem(
                    text: "Parler avec un spécialiste",
                    iconData: AppIcon.chat,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomsPage(),
                        ),
                      );
                    },
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

  void Function()? onPressed;

  AssistanceItem(
      {Key? key, required this.text, required this.iconData, this.onPressed})
      : super(key: key);

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
        onTap: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: AppTheme.darkGray,
      ),
    );
  }
}
