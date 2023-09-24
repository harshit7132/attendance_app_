// // ignore_for_file: library_private_types_in_public_api, unrelated_type_equality_checks, non_constant_identifier_names
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class Example extends StatefulWidget {
//   const Example({Key? key}) : super(key: key);
//   @override
//   _ExampleState createState() => _ExampleState();
// }
//
// class _ExampleState extends State<Example> {
//   TextEditingController EemailController = TextEditingController();
//   TextEditingController EpassController = TextEditingController();
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passController = TextEditingController();
//   TextEditingController CpassController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Colors.orangeAccent, Colors.pinkAccent],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter)),
//           child: Stack(children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 60),
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 300,
//                 width: double.infinity,
//                 child: Image.network(
//                     "https://cdn.leonardo.ai/users/b902c7b4-8ff8-42ac-9a8d-15c380dfbc89/generations/5955d0e0-e18c-46ac-b24c-a84b4109fd63/variations/Default_Cute_death_halloween_sweatshirt_fall_skull_skeleton_sp_1_5955d0e0-e18c-46ac-b24c-a84b4109fd63_1.jpg"),
//               ),
//             ),
//             SingleChildScrollView(
//               child: SizedBox(
//                 //Tab bar & Expended height
//                 height: 560.h,
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 400,
//                     ),
//                     Container(
//                       height: 50,
//                       width: 360,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: Colors.black12,
//                       ),
//                       child:  TabBar(
//                           dividerColor: Colors.transparent,
//                           unselectedLabelColor: Colors.white,
//                           labelColor: Colors.black,
//                           indicator: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                               color: Colors.white
//                               ),
//                           tabs: [
//                              const Tab(
//                               child: Text('    Existing     ',
//                                   style: TextStyle(fontSize: 23))
//                             ),
//                             Tab(
//                               child:
//                                   Text('       New                    ', style: TextStyle(fontSize: 23.sp)),
//                             )
//                           ]),
//                     ),
//                     const SizedBox(height: 40),
//                     Expanded(
//                         //Tab Bar View items
//                         child: Padding(
//                             padding: const EdgeInsets.only(right: 20, left: 20),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Colors.white,
//                                 ),
//                                 child: TabBarView(children: [
//                                   Exsisting(
//                                       emailController: EemailController,
//                                       passController: EpassController),
//                                   New(
//                                     emailController: emailController,
//                                     passController: passController,
//                                     CpassController: CpassController,
//                                   )
//                                 ]))))
//                   ],
//                 ),
//               ),
//             ),
//             const Button()
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// class Button extends StatelessWidget {
//   const Button({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       //floating button
//       top: 610.h,
//       left: 80.w,
//       child: Container(
//           alignment: Alignment.center,
//           height: 60.h,
//           width: 230.w,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               gradient:  const LinearGradient(colors: [
//                 Color.fromRGBO(23,175,224, 1),
//                 Color.fromRGBO(23,175,224, 1),
//                 Color.fromRGBO(102, 231, 226, 1),
//               ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
//           child: GestureDetector(
//             onTap: () {
//               //Login();
//             },
//             child: Text(TabBarView == New ? "Sign Up" : "LOGIN",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25.sp,
//                     fontWeight: FontWeight.bold)),
//           )),
//     );
//   }
// }