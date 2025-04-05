import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/ui/theme.dart'; // Ensure WHITE90 is defined here

class MyIconButton extends StatefulWidget {
  /// The asset path for the icon (SVG).
  final String iconAsset;

  /// Icon dimensions.
  final double iconWidth;
  final double iconHeight;

  /// Icon color.
  final Color iconColor;

  /// Button background color.
  final Color backgroundColor;

  /// Border color.
  final Color borderColor;

  /// The border width when not clicked.
  final double defaultBorderWidth;

  /// The border width when clicked.
  final double clickedBorderWidth;

  /// Overall button dimensions.
  final double width;
  final double height;

  /// Border radius.
  final double borderRadius;

  /// Duration for the click animation.
  final Duration animationDuration;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  const MyIconButton({
    Key? key,
    required this.iconAsset,
    this.iconWidth = 53,
    this.iconHeight = 53,
    this.iconColor = const Color(0xff393E46), // DARK_GRAY or your default
    this.backgroundColor = WHITE90,
    this.borderColor = const Color(0xff393E46),
    this.defaultBorderWidth = 3.0,
    this.clickedBorderWidth = 0.0,
    this.width = 56,
    this.height = 56,
    this.borderRadius = 13,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.onPressed,
  }) : super(key: key);

  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool isClicked = false;

  void clickAnimation() {
    // Toggle click state and call the onPressed callback.
    setState(() {
      isClicked = true;
    });
    widget.onPressed?.call();
    Timer(widget.animationDuration, () {
      setState(() {
        isClicked = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border(
          bottom: BorderSide(
            color: widget.borderColor.withValues(alpha: .25),
            width: isClicked ? widget.clickedBorderWidth : widget.defaultBorderWidth,
            style: BorderStyle.solid,

          ),

        ),
      ),
      width: widget.width,
      height: widget.height,
      child: Center(
        child: IconButton(
          onPressed: clickAnimation,
          icon: SvgPicture.asset(
            widget.iconAsset,
            width: widget.iconWidth,
            height: widget.iconHeight,
            color: widget.iconColor.withValues(alpha: .25),
          ),
        ),
      ),
    );
  }
}
