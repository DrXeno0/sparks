import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyButton extends StatefulWidget {
  /// The text displayed on the button.
  final String text;

  /// The SVG icon asset path.
  final String iconAsset;

  /// Button width.
  final double width;

  /// Button height.
  final double height;

  /// Button border radius.
  final double borderRadius;

  /// Background color of the button.
  final Color backgroundColor;

  /// Border color of the button.
  final Color borderColor;

  /// The border width when the button is not clicked.
  final double defaultBorderWidth;

  /// The border width when the button is clicked.
  final double clickedBorderWidth;

  /// Text style for the button's text.
  final TextStyle? textStyle;

  /// Duration for the click animation.
  final Duration animationDuration;

  /// Callback function to run when the button is pressed.
  final VoidCallback? onPressed;

  const MyButton({
    Key? key,
    required this.text,
    required this.iconAsset,
    this.width = 186,
    this.height = 56,
    this.borderRadius = 13,
    this.backgroundColor = const Color(0xff00adb5),
    this.borderColor = const Color(0xff087A7F),
    this.defaultBorderWidth = 3.0,
    this.clickedBorderWidth = 0.0,
    this.textStyle,
    this.animationDuration = const Duration(seconds: 1),
    this.onPressed,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isClicked = false;

  void _clickedButton() {
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
    final TextStyle style = widget.textStyle ??
        const TextStyle(
          fontFamily: "calibri",
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
    return GestureDetector(
      onTap: _clickedButton,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border(
            bottom: BorderSide(
              color: widget.borderColor,
              width: isClicked ? widget.clickedBorderWidth : widget.defaultBorderWidth,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.iconAsset,
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              widget.text,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
