import 'package:flutter/material.dart';

class RoundedCheckbox extends StatefulWidget {
  const RoundedCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 26,
    this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;
  final String? label;

  @override
  State<RoundedCheckbox> createState() => _RoundedCheckboxState();
}

class _RoundedCheckboxState extends State<RoundedCheckbox>
    with SingleTickerProviderStateMixin {
  late bool _checked = widget.value;
  late final AnimationController _ctlr = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
    upperBound: 0.15, // subtle press scale
  );

  static const _radius = 8.0;

  @override
  void didUpdateWidget(covariant RoundedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _checked = widget.value;
  }

  void _handleTap() {
    setState(() => _checked = !_checked);
    widget.onChanged(_checked);
  }

  @override
  void dispose() {
    _ctlr.dispose();
    super.dispose();
  }

  // Helper that returns the correct decoration for the current state
  BoxDecoration _buildDecoration({
    required bool checked,
    required Color primary,
    required Color idle,
  }) =>
      BoxDecoration(
        color: checked ? primary : Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: checked ? primary : idle, width: 1.3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final idleColor = Colors.grey.shade300;

    final box = GestureDetector(
      onTapDown: (_) => _ctlr.forward(),
      onTapUp: (_) => _ctlr.reverse().then((_) => _handleTap()),
      onTapCancel: () => _ctlr.reverse(),
      child: AnimatedBuilder(
        animation: _ctlr,
        builder: (_, child) => Transform.scale(
          scale: 1 - _ctlr.value,
          child: child,
        ),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration:
          _buildDecoration(checked: _checked, primary: primary, idle: idleColor),
          alignment: Alignment.center,
          child: _checked
              ? Icon(Icons.check,
              size: widget.size * 0.6, color: Colors.white)
              : const SizedBox.shrink(),
        ),
      ),
    );

    if (widget.label == null) return box;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        box,
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            widget.label!,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
