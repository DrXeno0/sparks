import 'package:flutter/material.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/view/components/gender_selector.dart';
import 'package:sparks/view/components/my_custom_button.dart';
import 'package:sparks/view/components/rounded_dropdown.dart';
import 'package:sparks/view/components/rounded_text_field.dart';

class AddSupervisorPage extends StatefulWidget {
  const AddSupervisorPage({Key? key}) : super(key: key);

  @override
  State<AddSupervisorPage> createState() => _AddSupervisorPageState();
}

class _AddSupervisorPageState extends State<AddSupervisorPage> {
  double kFieldMaxWidth = 400;

/* ── controllers & state ─────────────────────────────────── */
  final _nameC = TextEditingController();
  final _mailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _addrC = TextEditingController();

  final _idC = TextEditingController();

  Gender? _gender;
  String? _division;
  String? _department;

  final Map<String, String?> _errorMessage = {
    "full_name": null,
    "email": null,
    "phone": null,
    "address": null,
    "id": null,
  };

  bool _checkForEmptyFields() {
    final Map<String, String?> _controllerstate = {
      "full_name": _nameC.text,
      "email": _mailC.text,
      "phone": _phoneC.text,
      "address": _addrC.text,
      "id": _idC.text,
    };
    var size = _controllerstate.length;
    for (var key in _controllerstate.keys) {
      if (_controllerstate[key] == null ||
          _controllerstate[key]!.isEmpty ||
          _controllerstate[key] == "") {
        setState(() {
          _errorMessage[key] = "This field is required";
        });
        size--;
      }
    }
    return size == _controllerstate.length;
  }

  Widget _profileImage(double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.cyan.withOpacity(.2)),
          image: const DecorationImage(
            image: AssetImage('assets/images/unknown.png'),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _gap([double h = 30]) => SizedBox(height: h);

  Widget _fieldsColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _gap(6),
          _constrained(
              RoundedInputField(hint: 'Full Name', controller: _nameC)),
          _gap(),
          _constrained(RoundedInputField(hint: 'Email', controller: _mailC)),
          _gap(),
          _constrained(
              RoundedInputField(hint: 'Phone Number', controller: _phoneC)),
          _gap(),
          _constrained(RoundedInputField(hint: 'Address', controller: _addrC)),
          _gap(),
          _constrained(RoundedInputField(hint: 'ID', controller: _idC)),
          _gap(),
          _constrained(
            Row(
              children: [
                Expanded(
                  child: RoundedDropdown<String>(
                    hint: 'Division',
                    value: _division,
                    items: ['Design', 'Development', 'Marketing'],
                    onChanged: (v) => setState(() => _division = v),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: RoundedDropdown<String>(
                    hint: 'Department',
                    value: _department,
                    items: ['IT', 'HR', 'Finance', 'Marketing'],
                    onChanged: (v) => setState(() => _department = v),
                  ),
                ),
              ],
            ),
          ),
          _gap(),
          GenderSelector(
            value: _gender,
            onChanged: (g) => setState(() => _gender = g),
          ),
          _gap(),
          _constrained(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [MyButton(text: "add", iconAsset: Icons.add_rounded)])),
          _gap(),
        ],
      );

  Widget _constrained(Widget child) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: kFieldMaxWidth),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, cts) {
            final isWide = cts.maxWidth > 700;
            final imgSize = isWide ? 240.0 : cts.maxWidth * .45;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileImage(imgSize),
                  const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Profile',
                            style: TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato')),
                        const SizedBox(height: 24),
                        // ** Only this part scrolls **
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(right: 12),
                            child: _fieldsColumn(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
