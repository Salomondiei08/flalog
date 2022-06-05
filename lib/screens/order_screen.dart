import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/nothing_bougth.png'),
          SizedBox(height: 5.h,),
          Text('Vous n\'avez encore rien acheté', style: Theme.of(context).textTheme.headline2,),
        ],
      )),
    );
  }
}
