// ignore_for_file: unused_local_variable

import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/bloc/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGen {
  final BottomNavBloc bottomnavbloc = BottomNavBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<BottomNavBloc>.value(
                value: bottomnavbloc, child: const Home_page()));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error'), centerTitle: true),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
