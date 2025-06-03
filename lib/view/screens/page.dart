import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/nav_system/my_custome_nav.dart';
import 'package:sparks/view/screens/custom_title_bar.dart';
import 'package:window_manager/window_manager.dart';

class PageHost extends StatelessWidget {
  const PageHost({super.key});

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
            ValueListenableBuilder<String>(
              valueListenable: RouteController.currentRouteName,
              builder: (context, currentRoute, _) {
                return GestureDetector(
                  onPanStart: (details) => windowManager.startDragging(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ["profile", "supervisor_profile", "add_intern"]
                              .contains(currentRoute)
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                RouteController.goBack();
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 21, top: 21, right: 21),
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
