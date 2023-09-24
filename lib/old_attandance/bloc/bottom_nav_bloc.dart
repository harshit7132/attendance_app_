// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial(tabIndex: 0)) {
    on<BottomNavEvent>((event, emit) {
      if (event is Tabchange) {
        emit(BottomNavInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
