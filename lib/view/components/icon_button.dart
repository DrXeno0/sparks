import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/view/theme.dart'; // Ensure WHITE90 is defined here

class MyIconButton extends StatefulWidget {
  final String iconAsset;

  final double iconWidth;
  final double iconHeight;

  final Color iconColor;

  final Color backgroundColor;

  final Color borderColor;

  final double defaultBorderWidth;

  final double clickedBorderWidth;

  final double width;
  final double height;

  final double borderRadius;

  final Duration animationDuration;
  final VoidCallback? onPressed;

  const MyIconButton({
    super.key,
    required this.iconAsset,
    this.iconWidth = 53,
    this.iconHeight = 53,
    this.iconColor = const Color(0xff393E46),
    this.backgroundColor = white90,
    this.borderColor = const Color(0xff393E46),
    this.defaultBorderWidth = 3.0,
    this.clickedBorderWidth = 0.0,
    this.width = 56,
    this.height = 56,
    this.borderRadius = 13,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.onPressed,
  });

  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool isClicked = false;

  void clickAnimation() {
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
    return AnimatedContainer(
      duration: widget.animationDuration,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border(
          bottom: BorderSide(
            color: widget.borderColor.withValues(alpha: .25),
            width: isClicked ? widget.clickedBorderWidth : widget.defaultBorderWidth,
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
            colorFilter: ColorFilter.mode(widget.iconColor.withValues(alpha: 1.0), BlendMode.srcIn)
          ),
        ),
      ),
    );
  }
}
