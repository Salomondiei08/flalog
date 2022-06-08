import 'package:flalog/screens/account_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/map_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/sign_up_screen.dart';

class AppRoute {
  static const String home = '/home';
  static const String loginScreen = '/login_screen';
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String resetScreen = '/reset_screen';
  static const String overviewScreen = '/overview_screen';
  static const String onBoardingScreen = '/onboarding_screen';

  static const String drugDetailScreen = '/drug_detail_screen';
  static const String orderScreen = '/order_screen';
  static const String pharmacyListScreen = '/pha_list_screen';
  static const String pharmacyDetailScreen = '/pharmacy_detail_screen';
  static const String chatScreen = '/chat_screen';
  static const String aboutScreen = '/about_screen';
  static const String healthInfoScreen = '/health_info_screen';
  static const String profileScreen = '/profile_screen';
  static const String assistanceScreen = '/assistance_screen';
  static const String mapScreen = '/map_screen';
  static const String accountScreen = '/account_screen';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (BuildContext context) => const HomeScreen(),
    accountScreen: (BuildContext context) => const AccountScreen(),
    loginScreen: (BuildContext context) => const LoginScreen(),
    signInScreen: (BuildContext context) => const LoginScreen(),
    signUpScreen: (BuildContext context) => const SignUpScreen(),
    onBoardingScreen: (BuildContext context) => const OnboardingScreen(),
    // mapScreen : (BuildContext context) => MapScreen(),
    // orderScreen : (BuildContext context) => OrderScreen(),
    // pharmacyListScreen : (BuildContext context) => PharmacyListScreen(),
    // pharmacyDetailScreen : (BuildContext context) => PharmacyDetailScreen(),
    // chatScreen : (BuildContext context) => ChatScreen(),
    // aboutScreen : (BuildContext context) => AboutScreen(),
    // healthInfoScreen : (BuildContext context) => HealthInfoScreen(),
    // profileScreen : (BuildContext context) => ProfileScreen(),
    // assistanceScreen : (BuildContext context) => AssistanceScreen(),
    // mapScreen : (BuildContext context) => MapScreen(),
  };
}
