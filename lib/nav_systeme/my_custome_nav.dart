import 'package:flutter/material.dart';
import 'package:sparks/ui/screens/home_page.dart';


class RouteController {

  static final ValueNotifier<Widget> currentPage = ValueNotifier<Widget>(HomePage());


  static final ValueNotifier<String> currentRouteName = ValueNotifier<String>("home");

  static final List<_RouteEntry> _historyStack = [];
  static int _currentIndex = -1;


  static void goTo(Widget page, String routeName) {

    if (_currentIndex < _historyStack.length - 1) {
      _historyStack.removeRange(_currentIndex + 1, _historyStack.length);
    }
    _historyStack.add(_RouteEntry(page: page, name: routeName));
    _currentIndex++;

    currentPage.value = page;
    currentRouteName.value = routeName;
  }

  static void goBack() {
    if (_currentIndex > 0) {
      _currentIndex--;
      final entry = _historyStack[_currentIndex];
      currentPage.value = entry.page;
      currentRouteName.value = entry.name;
    }
  }
  static bool canGoBack() => _historyStack.isNotEmpty;


  static void goForward() {
    if (_currentIndex < _historyStack.length - 1) {
      _currentIndex++;
      final entry = _historyStack[_currentIndex];
      currentPage.value = entry.page;
      currentRouteName.value = entry.name;
    }
  }
}

class _RouteEntry {
  final Widget page;
  final String name;

  _RouteEntry({required this.page, required this.name});
}
