part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavState {
  final int tabIndex ;

  const BottomNavState({required this.tabIndex});
}

class BottomNavInitial extends BottomNavState {
  const BottomNavInitial({required super.tabIndex});
}
