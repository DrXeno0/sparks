// page_host.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/ui/screens/custom_title_bar.dart';
import 'package:sparks/ui/screens/home_page.dart';
import 'package:window_manager/window_manager.dart';
// Ensure this is the correct import

class PageHost extends StatelessWidget {
  const PageHost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(64),
              blurRadius: 4,
              spreadRadius: -3,
              offset: const Offset(-3, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Draggable title bar with dynamic back button
            ValueListenableBuilder<String>(
              valueListenable: RouteController.currentRouteName,
              builder: (context, currentRoute, _) {
                return GestureDetector(
                  onPanStart: (details) => windowManager.startDragging(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      currentRoute == "profile"
                          ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if(!RouteController.canGoBack()){
                          RouteController.goBack();}
                          else{
                            RouteController.goTo(HomePage(), "home");
                          }
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/back.svg",

                        ),
                      )
                          : const SizedBox(width: 10),
                      CustomTitleBar(),
                    ],
                  ),
                );
              },
            ),
            // Dynamic page area that rebuilds when the current page changes
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.only(left: 21, top: 21, right: 21),
                child: ValueListenableBuilder<Widget>(
                  valueListenable: RouteController.currentPage,
                  builder: (context, page, _) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: page,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
