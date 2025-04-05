import 'package:flutter/material.dart';
import 'package:sparks/ui/theme.dart'; // Ensure WHITE90 is defined here.

/// A widget that simulates an inner shadow by overlaying a gradient.
class InnerShadow extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur; // Not used directly in this simple version, but you could adjust stops.
  final Offset offset;
  final Color color;

  const InnerShadow({
    Key? key,
    required this.child,
    this.borderRadius = 13.0,
    this.blur = 10.0,
    this.offset = const Offset(2, 2),
    this.color = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Overlay a gradient to simulate inner shadow.
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
