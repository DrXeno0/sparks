import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  RoundedInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.errorText
  });

  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  String? errorText = null;

  static const _radius = 13.0;

  // Simple white card + subtle shadow
  BoxDecoration get _decoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(_radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  InputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(_radius),
    borderSide: BorderSide(color: color, width: 1.3),
  );

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final idleColor = Colors.grey.shade300;

    return Container(
      decoration: _decoration,

      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        cursorColor: primary,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          errorText: errorText,

          // Internal padding is now handled here
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          filled: true,
          fillColor: Colors.transparent,
          border: _border(idleColor),
          enabledBorder: _border(idleColor),
          focusedBorder: _border(primary),
          isDense: true,
        ),
      ),
    );
  }
}
