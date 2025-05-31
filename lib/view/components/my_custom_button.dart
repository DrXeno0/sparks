import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyButton extends StatefulWidget {
  final String text;

  final dynamic iconAsset;

  final Color color;

  final double width;

  final double height;

  final double borderRadius;

  final Color backgroundColor;

  final Color borderColor;

  final double defaultBorderWidth;

  final double clickedBorderWidth;

  final TextStyle? textStyle;

  final Duration animationDuration;
  final VoidCallback? onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.iconAsset,
    this.color = Colors.white,
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
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isClicked = false;

  void _clickedButton() {
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
        TextStyle(
          fontFamily: "calibri",
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: widget.color,
          decoration: TextDecoration.none,
        );
    return GestureDetector(
      onTap: _clickedButton,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border(
            bottom: BorderSide(
              color: widget.borderColor,
              width: isClicked
                  ? widget.clickedBorderWidth
                  : widget.defaultBorderWidth,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.iconAsset is String
                ? SvgPicture.asset(
                    widget.iconAsset,
                    width: 30,
                    height: 30,
                    color: widget.color,
                  )
                : Icon(widget.iconAsset, color: widget.color, size: 30),
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
