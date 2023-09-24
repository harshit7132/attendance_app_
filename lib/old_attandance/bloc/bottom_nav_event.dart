part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavEvent {}

class Tabchange extends BottomNavEvent {
  final int tabIndex;

  Tabchange({required this.tabIndex});
}
