import 'package:firebase_core/firebase_core.dart';
import 'package:flalog/providers/pharmacy_provider.dart';
import 'package:flalog/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flalog/theme/app_theme.dart';
import 'firebase_options.dart';
import 'helpers/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PharmacyProvider()),
          ],
          builder: (context, child) {
            return MaterialApp(
              title: 'Flalog',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              routes: AppRoute.routes,
              home: const OnboardingScreen(),
            );
          });
    });
  }
}
