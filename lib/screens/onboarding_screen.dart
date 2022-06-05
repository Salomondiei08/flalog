import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../helpers/authservice.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: getPage(),
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AuthService().handleAuth(),
            ),
          );
        },
        onSkip: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AuthService().handleAuth(),
            ),
          );
          // You can also override onSkip callback
        },
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(
            color: AppTheme.green,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        next: Icon(
          Icons.arrow_forward,
          color: AppTheme.green,
        ),
        done: Text("Done",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppTheme.green)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppTheme.green,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

List<PageViewModel> getPage() {
  return [
    PageViewModel(
      // title: "Never fill embarssaed again when prospecting",
      titleWidget: Text(
        "Bienvenue dans flalog, l'application qui va révolutionner la pharmacie",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.green,
          fontSize: 20,
        ),
      ),
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // Center(
          //   child: SizedBox(
          //     width: 300,
          //     child: Text(
          //       "RegisMe allows you to quickly register and save your prospects",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: AppTheme.green),
          //     ),
          //   ),
          // ),
        ],
      ),
      image: const Center(
        child: Image(
          image: AssetImage('assets/logo/ic_launcher.png'),
        ),
      ),
    ),
    PageViewModel(
      titleWidget: Text(
        "Trouver un médicament n'a jamais été aussi simple",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.green,
          fontSize: 20,
        ),
      ),
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      image: const Center(
        child: Image(
          image: AssetImage('assets/logo/ic_launcher.png'),
        ),
      ),
    ),
    PageViewModel(
      titleWidget: Text(
        "Profitez-en dès maintenant",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.green,
          fontSize: 20,
        ),
      ),
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      image: const Center(
        child: Image(
          image: AssetImage('assets/logo/ic_launcher.png'),
        ),
      ),
    ),
  ];
}
