import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoundedDateInputField extends StatefulWidget {
  RoundedDateInputField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.format = 'yyyy-MM-dd',
    this.errorText
  });

  final String hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String format;
  String? errorText;
  final ValueChanged<DateTime?> onChanged;

  @override
  State<RoundedDateInputField> createState() => _RoundedDateInputFieldState();
}

class _RoundedDateInputFieldState extends State<RoundedDateInputField> {
  final _controller = TextEditingController();
  late final DateFormat _fmt = DateFormat(widget.format);
  DateTime? _selected;

  static const _radius = 13.0;

  // Simple white card + faint shadow
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



  // Helper to build the outline; idle vs. focus colors
  InputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(_radius),
    borderSide: BorderSide(color: color, width: 1.3),
  );

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selected ?? widget.initialDate ?? now,
      firstDate: widget.firstDate ?? DateTime(now.year - 80),
      lastDate: widget.lastDate ?? DateTime(now.year + 10),
    );

    if (picked != null) {
      setState(() {
        _selected = picked;
        _controller.text = _fmt.format(picked);
      });
      widget.onChanged(picked);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final idleColor = Colors.grey.shade300;

    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        decoration: _decoration,
        alignment: Alignment.center,
        child: AbsorbPointer(
          child: TextField(
            controller: _controller,
            readOnly: true,
            cursorColor: primary,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: const Icon(Icons.calendar_today_rounded, size: 20),
              border: _border(idleColor),
              enabledBorder: _border(idleColor),
              errorText: widget.errorText,
              focusedBorder: _border(primary),
              isDense: true,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
        ),
      ),
    );
  }
}
