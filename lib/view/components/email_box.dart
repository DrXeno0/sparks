import 'package:flutter/material.dart';

class EmailComposeBox extends StatefulWidget {
  const EmailComposeBox({
    super.key,
    required this.onSend,
  });

  /// Returns (subject, body) when the user taps **Send**.
  final void Function(String subject, String body) onSend;

  @override
  State<EmailComposeBox> createState() => _EmailComposeBoxState();
}

class _EmailComposeBoxState extends State<EmailComposeBox> {
  final _subjectC = TextEditingController();
  final _bodyC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static const _radius = 13.0;

  BoxDecoration get _cardDeco => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      );

  InputBorder _outline(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: c, width: 1.3),
      );

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final idle = Colors.grey.shade300;

    return Container(
      decoration: _cardDeco,
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /* ── subject field ────────────────────────── */
            TextFormField(
              controller: _subjectC,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Subject required' : null,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: _outline(idle),
                enabledBorder: _outline(idle),
                focusedBorder: _outline(primary),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),

            /* ── body field (multiline) ───────────────── */
            TextFormField(
              controller: _bodyC,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Message',
                alignLabelWithHint: true,
                border: _outline(idle),
                enabledBorder: _outline(idle),
                focusedBorder: _outline(primary),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            /* ── send button ─────────────────────────── */
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Send'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSend(
                      _subjectC.text.trim(),
                      _bodyC.text.trim(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subjectC.dispose();
    _bodyC.dispose();
    super.dispose();
  }
}
