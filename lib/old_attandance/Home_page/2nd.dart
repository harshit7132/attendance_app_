// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

class Container_page extends StatefulWidget {
  const Container_page({super.key});
  @override
  State<Container_page> createState() => _Container_pageState();
}

class _Container_pageState extends State<Container_page>
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
      body: SafeArea(
        child: Column(
          children: [
            Image.network(
              "https://cdn.leonardo.ai/users/3a8d88ab-4807-4856-8f75-227b20eedba9/generations/102d8663-dc5c-41c0-bfcd-a35cd2be38de/variations/Default_isometric_view_of_a_chibi_cute_hyperrealistic_futurist_2_102d8663-dc5c-41c0-bfcd-a35cd2be38de_1.jpg",
              height: 370,
              width: 200,
            ),
            Container(
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TabBar(
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.black,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        indicatorColor: Colors.white,
                        controller: tabController,
                        tabs: const [
                          Tab(
                            child: Text('Existing',
                                style: TextStyle(fontSize: 20)),
                          ),
                          Tab(
                            child: Text('New', style: TextStyle(fontSize: 20)),
                          )
                        ]),
                    Expanded(
                        child:
                            TabBarView(controller: tabController, children: const []))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//  Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Colors.orangeAccent, Colors.pink],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter)),