import 'package:flutter/material.dart';

class User_B_Nav extends StatefulWidget {
  const User_B_Nav({super.key});

  @override
  State<User_B_Nav> createState() => _User_B_NavState();
}

class _User_B_NavState extends State<User_B_Nav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('user'),
      ),
    );
  }
}
