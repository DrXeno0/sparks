// page_host.dart
import 'package:flutter/material.dart';
import 'package:sparks/ui/screens/custom_title_bar.dart';
import 'package:window_manager/window_manager.dart';

class PageHost extends StatefulWidget {
  final Widget pageHosted;
  const PageHost({Key? key, required this.pageHosted}) : super(key: key);
  @override
  State<PageHost> createState() => _PageHostState();
}

class _PageHostState extends State<PageHost> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: -3,
              offset: const Offset(-3, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onPanStart: (details) => windowManager.startDragging(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Positioned(top: 0,right: 0,child: CustomTitleBar()),
                ],
              ),
            ),
            Expanded(child: widget.pageHosted),
          ],
        ),
      ),
    );
  }
}
