import 'package:flutter/material.dart';
import 'package:sparks/controller/form_validation_controller.dart';
import 'package:sparks/model/intern.dart';
import 'package:sparks/nav_systeme/my_custome_nav.dart';
import 'package:sparks/repository/database_repository.dart';
import 'package:sparks/utils/email_helper.dart';
import 'package:sparks/view/screens/home_page.dart';

class InternForumController extends ForumValidationController {
  final DatabaseRepository _databaseRepository = DatabaseRepository();

  bool _validateIntern(BuildContext context, Intern intern) {
    if (!validateEmail(intern.email)) {
      final snackBar = SnackBar(
        content: Text('Invalid email address.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }
    if (!validatePhone(intern.phone)) {
      final snackBar = SnackBar(
        content: Text('Invalid phone number.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }
    if (!validateName(intern.name)) {
      final snackBar = SnackBar(
        content: Text('Invalid name.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateAddress(intern.address)) {
      final snackBar = SnackBar(
        content: Text('Invalid address.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateID(intern.cin)) {
      final snackBar = SnackBar(
        content: Text('Invalid id'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateReference(intern.ref)) {
      final snackBar = SnackBar(
        content: Text('Invalid reference.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateDate(intern.startDate, intern.endDate ?? DateTime.now())) {
      final snackBar = SnackBar(
        content: Text('end date must be after start date.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateSupervisor(intern.supervisors)) {
      final snackBar = SnackBar(
        content:
            Text('You need at least one supervisor to add an intern 😊😊😊.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateDivision(intern.division)) {
      final snackBar = SnackBar(
        content: Text('Invalid division.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateDepartment(intern.department)) {
      final snackBar = SnackBar(
        content: Text('Invalid department.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  void acceptInternEmail(BuildContext context, Intern intern) {
    EmailHelper.sendEmail(
        toEmail: '${intern.email}',
        subject: 'you have been accepted as an intern in CNRST',
        body: 'hello, ${intern.name}this is the body of the email');
  }

  void addIntern(BuildContext context, Intern intern) {
    if (_validateIntern(context, intern)) {
      _databaseRepository.insertIntern(intern);
      acceptInternEmail(context, intern);
      RouteController.goBack();
      RouteController.goTo(HomePage(), "home");
    }
  }
}
