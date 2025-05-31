import 'package:flutter/material.dart';

/// Universal dropdown that mimics the rounded-edge style in your mockup.
/// Plug any list of strings (or map it to DropdownMenuItem<T>).
class RoundedDropdown<T> extends StatelessWidget {
  RoundedDropdown({
    super.key,
    required this.items,
    required this.hint,
    this.value,
    this.onChanged,
    this.errorText
  });

  final List<T> items;
  final String hint;
  final T? value;
  String? errorText;
  final ValueChanged<T?>? onChanged;

  static const _radius = 13.0;

  BoxDecoration get _boxDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(_radius),
    border: Border.all(color: const Color(0xFFBDBDBD)),
    color: Colors.white,
  );

  InputBorder get _border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(_radius),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _boxDecoration,

      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(_radius),
          decoration: InputDecoration(
            errorText: errorText,
            enabledBorder: _border,
            focusedBorder: _border,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          hint: Text(
            hint,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          items: items
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
