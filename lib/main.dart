import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sparks/repository/database_repository.dart';
import 'package:sparks/view/screens/nav_host.dart';
import 'package:sparks/view/screens/page.dart';
import 'package:sparks/view/screens/splash_screen.dart';
import 'package:sparks/view/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseRepository().init();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(1024, 720),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Sparks"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget screen = SplashScreen();

  void switchScreen() {
    setState(() {
      screen = _ScreenHost();
    });
  }

  Widget _ScreenHost() {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, white90],
            stops: const [0, 1],
            begin: const Alignment(0, 0),
            end: const Alignment(1, 1),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 13, top: 13, bottom: 13),
          child: Row(
            children: [
              NavHost(),
              PageHost(),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      switchScreen();
    });

    return screen;
  }
}
