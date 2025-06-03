import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/nav_system/my_custome_nav.dart';
import 'package:sparks/view/screens/history_page.dart';
import 'package:sparks/view/screens/home_page.dart';
import 'package:sparks/view/screens/stats_page.dart';
import 'package:sparks/view/screens/supervisor_page.dart';
import 'package:sparks/view/theme.dart';
import 'package:window_manager/window_manager.dart';

typedef RouteChangedCallback = void Function(String newRoute);

class NavHost extends StatefulWidget {
  const NavHost({super.key});

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
                          },
                        ),
                        const SizedBox(height: 27),
                        NavLinkElement(
                          iconPath: "assets/icons/Date.svg",
                          label: "SuperVisor",
                          isSelected: currentRoute == "supervisor",
                          onClick: () {
                            RouteController.goTo(
                                SuperVisorPage(), "supervisor");
                          },
                        ),
                        const SizedBox(height: 27),
                        NavLinkElement(
                          iconPath: "assets/icons/curve.svg",
                          label: "Stats",
                          isSelected: currentRoute == "stats",
                          onClick: () {
                            RouteController.goTo(StatsPage(), "stats");
                          },
                        ),
                        const SizedBox(height: 27),
                        NavLinkElement(
                          iconPath: "assets/icons/history.svg",
                          label: "History",
                          isSelected: currentRoute == "history",
                          onClick: () {
                            RouteController.goTo(HistoryPage(), "history");
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 75,
                  color: Colors.cyan,
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
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
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
                isSelected ? Colors.cyan : darkGray,
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
                    color: isSelected ? Colors.cyan : darkGray,
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
