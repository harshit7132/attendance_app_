import 'package:attendance_app/Home_page/2nd.dart';
import 'package:attendance_app/tabbarPage.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Specify the number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  // Add your tab content here
                  Center(child: Text('Tab 1')),
                  Center(child: Text('Tab 2')),
                  Center(child: Text('Tab 3')),
                ],
              ),
            ),
            TabBar(
              tabs: [
                // Add your tab labels here
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
            ),
          ],
        ),
      ),
    );
  }
}
