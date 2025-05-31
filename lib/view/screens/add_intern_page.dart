import 'package:flutter/material.dart';
import 'package:sparks/controller/intern_forum_controller.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/intern.dart';
import 'package:sparks/view/components/date_input_field.dart';
import 'package:sparks/view/components/gender_selector.dart';
import 'package:sparks/view/components/my_custom_button.dart';
import 'package:sparks/view/components/rounded_check_box.dart';
import 'package:sparks/view/components/rounded_dropdown.dart';
import 'package:sparks/view/components/rounded_text_field.dart';
import 'package:sparks/view/components/supervisor_selector.dart';
import 'package:sparks/view/theme.dart';

class AddInternPage extends StatefulWidget {
  const AddInternPage({Key? key}) : super(key: key);

  @override
  State<AddInternPage> createState() => _AddInternPageState();
}

class _AddInternPageState extends State<AddInternPage> {
  final controller = InternForumController();

  double kFieldMaxWidth = 400;

  final _nameC = TextEditingController();
  final _mailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _addrC = TextEditingController();
  final _refC = TextEditingController();
  final _idC = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<int> _supervisors = [];

  Gender _gender = Gender.unknown;
  String? _division;
  String? _department;
  bool _insurance = false;

  Map<String, String?> _errorMessage = {
    "full_name": null,
    "email": null,
    "phone": null,
    "address": null,
    "ref": null,
    "id": null,
    "start_date": null,
    "end_date": null,
    "division": null,
    "department": null,
    "supervisor": null,
  };
  late Map<String, String?> _controllerstate = {
    "full_name": _nameC.text,
    "email": _mailC.text,
    "phone": _phoneC.text,
    "address": _addrC.text,
    "ref": _refC.text,
    "id": _idC.text,
    "start_date": _startDate.toString(),
    "end_date": _endDate.toString(),
    "division": _division,
    "department": _department,
    "supervisor": _supervisors.toString(),
  };

  bool _checkForEmptyFields() {
    var size = _controllerstate.length;
    _controllerstate.forEach((key, value) {
      if (value == null ||
          value.isEmpty ||
          value == "" ||
          value == "null" ||
          value == "[]" ||
          value == []) {
        setState(() {
          _errorMessage[key] = "This field is required";
          size--;
        });
      }
      ;
    });
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
          _constrained(RoundedInputField(
            hint: 'Full Name',
            controller: _nameC,
            errorText: _errorMessage["full_name"],
          )),
          _gap(),
          _constrained(RoundedInputField(
              hint: 'Email',
              controller: _mailC,
              errorText: _errorMessage["email"])),
          _gap(),
          _constrained(RoundedInputField(
              hint: 'Phone Number',
              controller: _phoneC,
              errorText: _errorMessage["phone"])),
          _gap(),
          _constrained(RoundedInputField(
              hint: 'Address',
              controller: _addrC,
              errorText: _errorMessage["address"])),
          _gap(),
          _constrained(RoundedInputField(
              hint: 'Ref', controller: _refC, errorText: _errorMessage["ref"])),
          _gap(),
          _constrained(RoundedInputField(
              hint: 'ID', controller: _idC, errorText: _errorMessage["id"])),
          _gap(),
          _constrained(
            RoundedDateInputField(
              errorText: _errorMessage["start_date"],
              hint: 'Start Date',
              initialDate: DateTime.now(),
              onChanged: (d) => setState(() => _startDate = d),
            ),
          ),
          _gap(),
          _constrained(
            RoundedDateInputField(
              errorText: _errorMessage["end_date"],
              hint: 'End Date',
              initialDate: DateTime.now(),
              onChanged: (d) => setState(() => _endDate = d),
            ),
          ),
          _gap(),
          _constrained(
            Row(
              children: [
                Expanded(
                  child: RoundedDropdown<String>(
                    errorText: _errorMessage["division"],
                    hint: 'Division',
                    value: _division,
                    items: ['Design', 'Development', 'Marketing'],
                    onChanged: (v) => setState(() => _division = v),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: RoundedDropdown<String>(
                    errorText: _errorMessage["department"],
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
          _constrained(SupervisorSelector(
            errorText: _errorMessage["supervisor"],
            allOptions: [1, 2, 3, 4],
            selected: _supervisors,
            onChanged: (list) => setState(() => _supervisors = list),
          )),
          _gap(),
          _constrained(RoundedCheckbox(
            value: _insurance,
            onChanged: (bool value) {
              _insurance = value;
            },
            label: "Insurance",
          )),
          _gap(),
          GenderSelector(
            value: _gender,
            onChanged: (g) => setState(() => _gender = g),
          ),
          _gap(),
          _constrained(Row(children: [
            MyButton(
              text: "accept",
              iconAsset: Icons.check_rounded,
              backgroundColor: Colors.green,
              onPressed: () {
                if (_checkForEmptyFields()) {
                  print("accepted");
                  controller.addIntern(
                      context,
                      Intern(
                          name: _nameC.text,
                          role: "N/A",
                          supervisors: _supervisors,
                          ref: _refC.text,
                          phone: _phoneC.text,
                          gender: _gender,
                          department: _department!,
                          division: _division!,
                          startDate: _startDate!,
                          endDate: _endDate,
                          address: _addrC.text,
                          email: _mailC.text,
                          cin: _idC.text));
                }

                ;

                return;
              },
            ),
            const SizedBox(width: 24),
            MyButton(
              text: "reject",
              iconAsset: Icons.close_rounded,
              backgroundColor: Colors.red,
              borderColor: darkRed,
            ),
          ])),
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
            final isWide = cts.maxWidth > 700; // desktop / web
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
