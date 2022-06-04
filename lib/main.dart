import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flalog/theme/app_theme.dart';
import 'firebase_options.dart';
import 'helpers/authservice.dart';
import 'helpers/routes.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Flalog());
}

class Flalog extends StatelessWidget {
  const Flalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Flalog',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        routes: AppRoute.routes,
       home: AuthService().handleAuth(),
      );
    });
  }
}
