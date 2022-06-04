import 'package:flalog/screens/pharmact_list.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import 'assistance_screen.dart';
import 'order_screen.dart';
import 'overview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  final List<Map<String, Widget>> _pages = [
    {
      "page": OverviewScreen(),
    },
    {
      "page": const OrderScreen(),
    },
    {
      "page": const PharmacyList(),
    },
    {
      "page": const AssistanceScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex]["page"],
      bottomNavigationBar: AppNavigationBar(
        currentIndex: currentIndex,
        listOfIcons: listOfIcons,
        onTap: selectElement,
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.shopping_cart_rounded,
    Icons.medication,
    Icons.person_rounded,
  ];

  void selectElement(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
