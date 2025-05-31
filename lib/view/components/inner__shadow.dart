import 'package:flutter/material.dart';



class InnerShadow extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final Offset offset;
  final Color color;

  const InnerShadow({
    super.key,
    required this.child,
    this.borderRadius = 13.0,
    this.blur = 10.0,
    this.offset = const Offset(2, 2),
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.3),
                  Colors.transparent,
                  Colors.transparent,
                  color.withOpacity(0.3),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
