// main.dart
import 'package:flutter/material.dart';
import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/ui/screens/history_page.dart';
import 'package:sparks/ui/screens/home_page.dart';
import 'package:sparks/ui/screens/page.dart';
import 'package:sparks/ui/screens/stats_page.dart';
import 'package:sparks/ui/screens/supervisor_page.dart';
import 'package:sparks/ui/screens/nav_host.dart';
import 'package:sparks/ui/theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:sparks/ui/screens/custom_title_bar.dart';
// NavRoute static class

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions =  const  WindowOptions(
    minimumSize: Size(1024, 720),

    // You can also set other options, e.g.,
    // size: Size(800, 600),  // Initial size
    // center: true,       // Center the window on the screen
    // backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    // alwaysOnTop: false,
    // fullScreen: false,
    // title: 'Your App Title',
  );


;

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  /// This method returns the widget for the current route.


  @override
  Widget build(BuildContext context) {

    // Whenever a nav item is clicked, we trigger setState so that PageHost rebuilds.
    return

       Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [WHITE90, WHITE60],
            stops: const [0.75, 1.0],
            begin: const Alignment(0.5, 0),
            end: const Alignment(0.5, 1),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 13, top: 13, bottom: 13),
          child: Row(
            children: [

              // Pass a callback to NavHost so it can notify when a route changes.
              NavHost(
                onRouteChanged: (String route) {
                  setState(() {}); // Rebuild to update PageHost
                },
              ),
              // PageHost uses the current route from NavRoute
              PageHost(

              ),
            ],
          ),

    ));
  }
}


