// nav_route.dart
import 'dart:ui';

const WHITE90 = Color(0xFFEEEEEE);
const WHITE60 = Color(0xFFe4E4E4);
const DARK_GRAY = Color(0xff393E46);

class NavRoute {
  static String _route = "/home";
  static void setRoute(String r) {
    _route = r;
  }
  static String getRoute() {
    return _route;
  }
}
