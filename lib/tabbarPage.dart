import 'package:attendance_app/tabbarPage/tab1.dart';
import 'package:attendance_app/tabbarPage/tab2.dart';
import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tab bar Without Appbar'),
      ),
      body: Container(
        height: 800,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.pink],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // height: 50,
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black12,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TabBar(
                              dividerColor: Colors.transparent,
                              unselectedLabelColor: Colors.white,
                              labelColor: Colors.black,
                              indicatorWeight: 2,
                              indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              indicatorColor: Colors.white,
                              controller: tabController,
                              tabs: [
                                Tab(
                                  child: Text('Existing',
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Tab(
                                  child: Text('New',
                                      style: TextStyle(fontSize: 20)),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Tab1(),
                        Tab2(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
