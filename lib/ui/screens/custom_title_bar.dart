import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

        Container(
          clipBehavior: Clip.none,
          height: 28,
          // Typical title bar height
          color: Colors.transparent,  // Or your preferred background color
          child: Row(
            children: [
              // Title (or App Icon)
               // Push controls to the right
              // Minimize Button
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/icon=remove.svg',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => windowManager.minimize(),
                hoverColor: Colors.cyan,
              ),
              // Maximize/Restore Button (Icon changes dynamically)
              _MaximizeRestoreButton(),
              // Close Button
              IconButton(

                icon: SvgPicture.asset(
                  'assets/icons/icon=Cancel.svg',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => windowManager.close(),
                hoverColor: Colors.red,
              ),
            ],
          ),
        );

  }
}


class _MaximizeRestoreButton extends StatefulWidget {
  @override
  State<_MaximizeRestoreButton> createState() => _MaximizeRestoreButtonState();
}

class _MaximizeRestoreButtonState extends State<_MaximizeRestoreButton> {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    _checkMaximized();
  }

  Future<void> _checkMaximized() async {
    _isMaximized = await windowManager.isMaximized();
    setState(() {}); // Update the UI with the correct icon
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        _isMaximized
            ? 'assets/icons/minimize.svg'
            : 'assets/icons/maximize.svg',
        width: 24,
        height: 24,
      ),
      onPressed: () async {
        if (_isMaximized) {
          await windowManager.restore();
        } else {
          await windowManager.maximize();
        }
        await _checkMaximized(); // Update the icon after the action
      },
      hoverColor: Colors.limeAccent,
    );
  }
}