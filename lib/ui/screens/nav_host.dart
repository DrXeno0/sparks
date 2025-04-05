import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/ui/screens/history_page.dart';
import 'package:sparks/ui/screens/home_page.dart';
import 'package:sparks/ui/screens/stats_page.dart';
import 'package:sparks/ui/screens/supervisor_page.dart';
import 'package:window_manager/window_manager.dart';
import 'package:sparks/ui/theme.dart';


// Callback for route changes (if needed in parent)
typedef RouteChangedCallback = void Function(String newRoute);

class NavHost extends StatefulWidget {
  final RouteChangedCallback onRouteChanged;

  const NavHost({Key? key, required this.onRouteChanged}) : super(key: key);

  @override
  State<NavHost> createState() => _NavHostState();
}

class _NavHostState extends State<NavHost> {
  double responsiveNavWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 1024 ? 345 : 100;
  }

  @override
  Widget build(BuildContext context) {
    final navWidth = responsiveNavWidth(context);
    return GestureDetector(
      excludeFromSemantics: true,
      onPanStart: (details) => windowManager.startDragging(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: navWidth,
        child: Stack(
          children: [
            // Center navigation links
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ValueListenableBuilder<String>(
                  valueListenable: RouteController.currentRouteName,
                  builder: (context, currentRoute, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NavLinkElement(
                          iconPath: "assets/icons/Home.svg",
                          label: "Home",
                          isSelected: currentRoute == "home",
                          onClick: () {
                            RouteController.goTo(HomePage(), "home");
                            widget.onRouteChanged("home");
                          },
                        ),
                        const SizedBox(height: 27),
                        NavLinkElement(
                          iconPath: "assets/icons/Date.svg",
                          label: "SuperVisor",
                          isSelected: currentRoute == "supervisor",
                          onClick: () {
                            // Replace with your Supervisor page widget.
                            RouteController.goTo(SuperVisorPage(), "supervisor");
                            widget.onRouteChanged("supervisor");
                          },
                        ),
                        const SizedBox(height: 27),
                        NavLinkElement(
                          iconPath: "assets/icons/curve.svg",
                          label: "Stats",
                          isSelected: currentRoute == "stats",
                          onClick: () {
                            RouteController.goTo(StatsPage(), "stats");
                            widget.onRouteChanged("stats");
                          },
                        ),
                        const SizedBox(height: 27),
                        NavLinkElement(
                          iconPath: "assets/icons/history.svg",
                          label: "History",
                          isSelected: currentRoute == "history",
                          onClick: () {
                            RouteController.goTo(HistoryPage(), "history");
                            widget.onRouteChanged("history");
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // Optional logo at top center for wider nav.
            if (navWidth > 150 && MediaQuery.of(context).size.height > 545)
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 75,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NavLinkElement extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onClick;

  const NavLinkElement({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine if label should be shown based on screen width.
    final navWidth = MediaQuery.of(context).size.width > 1024 ? 345 : 150;
    final showLabel = navWidth > 150;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 4.53,
              height: 53,
              color: isSelected ? Colors.cyan : Colors.transparent,
            ),
            SizedBox(width: showLabel ? 31 : 17),
            SvgPicture.asset(
              iconPath,
              width: 53,
              height: 53,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.cyan : DARK_GRAY,
                BlendMode.srcIn,
              ),
            ),
            if (showLabel) ...[
              const SizedBox(width: 31),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  label,
                  key: ValueKey<bool>(showLabel),
                  style: TextStyle(
                    color: isSelected ? Colors.cyan : DARK_GRAY,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w200,
                    fontSize: 24,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
