
abstract class BottomNavEvent {}

class Tabchange extends BottomNavEvent {
  final int tabIndex;

  Tabchange({required this.tabIndex});
}
