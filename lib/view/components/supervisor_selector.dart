import 'package:flutter/material.dart';

class SupervisorSelector extends StatefulWidget {
  SupervisorSelector(
      {super.key,
      required this.allOptions,
      required this.selected,
      required this.onChanged,
      this.max = 5,
      this.hint = 'Select supervisors',
      this.errorText});

  final List<int> allOptions;
  final List<int> selected; // current selections
  final ValueChanged<List<int>> onChanged; // callback every change
  final int max;
  final String hint;
  String? errorText;

  @override
  State<SupervisorSelector> createState() => _SupervisorSelectorState();
}

class _SupervisorSelectorState extends State<SupervisorSelector> {
  /* ── controllers ───────────────────────────────────────── */
  final _textC = TextEditingController();
  final _focus = FocusNode();
  final _fieldKey = GlobalKey(); // → for measuring width

  /* ── visual constants ──────────────────────────────────── */
  static const _radius = 13.0;

  // White card + faint shadow
  BoxDecoration get _boxDeco => BoxDecoration(
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

  // Outline helper
  InputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: color, width: 1.3),
      );

  /* ── helpers ───────────────────────────────────────────── */
  void _add(name) {
    if (name == null ||
        widget.selected.contains(name) ||
        widget.selected.length >= widget.max) return;

    widget.onChanged([...widget.selected, name]);
    _textC.clear();
    _focus.requestFocus();
  }

  void _remove(int name) {
    final updated = [...widget.selected]..remove(name);
    widget.onChanged(updated);
    _focus.requestFocus();
  }

  @override
  void dispose() {
    _textC.dispose();
    _focus.dispose();
    super.dispose();
  }

  /* ── build ─────────────────────────────────────────────── */
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final idleColor = Colors.grey.shade300;

    // Options that haven’t been picked yet
    final suggestions =
        widget.allOptions.where((e) => !widget.selected.contains(e)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* ── chosen chips ────────────────────────────────── */
        if (widget.selected.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selected
                .map(
                  (name) => Chip(
                    label: Text(name.toString()),
                    backgroundColor: primary.withOpacity(0.15),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => _remove(name),
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                )
                .toList(),
          ),
        if (widget.selected.isNotEmpty) const SizedBox(height: 12),

        /* ── rounded autocomplete field ─────────────────── */
        Container(
          key: _fieldKey,
          decoration: _boxDeco,
          alignment: Alignment.center,
          child: RawAutocomplete<int>(
            focusNode: _focus,
            textEditingController: _textC,
            optionsBuilder: (TextEditingValue text) {
              if (text.text.trim().isEmpty) return const Iterable<int>.empty();
              return suggestions
                  .where(
                    (e) => e.toString().contains(text.text.toLowerCase()),
                  )
                  .cast<int>();
            },
            onSelected: _add,
            fieldViewBuilder: (ctx, controller, focusNode, onFieldSubmitted) =>
                TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: widget.selected.length < widget.max,
              onSubmitted: (v) => _add(v.trim()),
              decoration: InputDecoration(
                errorText: widget.errorText,
                hintText: widget.hint,
                border: _border(idleColor),
                enabledBorder: _border(idleColor),
                focusedBorder: _border(primary),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
            optionsViewBuilder: (ctx, onSelected, options) {
              final inputWidth =
                  (_fieldKey.currentContext?.findRenderObject() as RenderBox?)
                          ?.size
                          .width ??
                      300.0;

              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: inputWidth,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: options
                          .map(
                            (e) => ListTile(
                              title: Text(e.toString()),
                              hoverColor: primary.withOpacity(0.06),
                              onTap: () => onSelected(e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        /* ── max reached helper ─────────────────────────── */
        if (widget.selected.length >= widget.max)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'Maximum of ${widget.max} supervisors selected',
              style: TextStyle(color: Colors.red.shade600, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
