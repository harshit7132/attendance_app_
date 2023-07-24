import 'package:flutter/material.dart';

class First_Tab_page extends StatefulWidget {
  const First_Tab_page({super.key});

  @override
  State<First_Tab_page> createState() => _First_Tab_pageState();
}

class _First_Tab_pageState extends State<First_Tab_page> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('first'),
      ],
    );
  }
}
