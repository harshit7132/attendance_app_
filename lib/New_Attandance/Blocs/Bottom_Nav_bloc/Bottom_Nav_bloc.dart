// ignore_for_file: depend_on_referenced_packages

import 'package:attendance_app/New_Attandance/Blocs/Bottom_Nav_bloc/Bottom_Nav_Events.dart';
import 'package:attendance_app/New_Attandance/Blocs/Bottom_Nav_bloc/Bottom_Nav_States.dart';
import 'package:bloc/bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial(tabIndex: 0)) {
    on<BottomNavEvent>((event, emit) {
      if (event is Tabchange) {
        emit(BottomNavInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
