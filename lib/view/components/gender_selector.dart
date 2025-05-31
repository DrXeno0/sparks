import 'package:flutter/material.dart';
import 'package:sparks/model/gender.dart';




class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 64,
  });

  final Gender? value;
  final ValueChanged<Gender> onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _GenderCircle(
          size: size,
          icon: Icons.male,
          color: Colors.cyan,
          selected: value == Gender.male,
          onTap: () => onChanged(Gender.male),
        ),
        SizedBox(width: size * .25),
        _GenderCircle(
          size: size,
          icon: Icons.female,
          color: Colors.pinkAccent,
          selected: value == Gender.female,
          onTap: () => onChanged(Gender.female),
        ),
      ],
    );
  }
}

/// Internal building-block for a single circular button.
class _GenderCircle extends StatelessWidget {
  const _GenderCircle({
    required this.size,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final double size;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            // subtle shadow to float above background
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          // tinted halo if selected
          border: selected
              ? Border.all(color: color.withOpacity(0.5), width: 3)
              : null,
        ),
        child: Icon(icon, size: size * .45, color: color, weight: 600),
      ),
    );
  }
}
