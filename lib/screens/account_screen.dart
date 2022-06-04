import 'package:flutter/material.dart';
import '../helpers/authservice.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You are logged in'),
        ElevatedButton(
            onPressed: () {
              AuthService().signOut();
            },
            child: Center(child: Text('LOG OUT')))
      ],
    ),
  );
}
