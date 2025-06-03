import 'package:flutter/material.dart';
import 'package:sparks/controller/form_validation_controller.dart';
import 'package:sparks/model/intern.dart';
import 'package:sparks/nav_system/my_custome_nav.dart';
import 'package:sparks/repository/database_repository.dart';
import 'package:sparks/utils/PdfGenerator.dart';
import 'package:sparks/utils/email_helper.dart';
import 'package:sparks/utils/notification_helper.dart';
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
    try {
      EmailHelper.sendEmail(
          toEmail: '${intern.email}',
          subject: 'you have been accepted as an intern in CNRST',
          body: 'hello, ${intern.name}this is the body of the email');
    } on Exception catch (e) {
      final snackBar = SnackBar(
        content: Text('Error sending email: $e'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw Exception('Error sending email: $e');
    }
  }

  void rejectInternEmail(BuildContext context, String name, String email) {
    try {
      EmailHelper.sendEmail(
          toEmail: '${email}',
          subject: 'you have been rejected as an intern in CNRST',
          body:
              '''bonjour ${name},\n\nSuite à votre demande  de stage déposée au CNRST,  nous sommes au regret de vous informer que nous ne pouvons y donner une suite favorable.\nToutefois, ce refus ne remet  pas en cause vos qualités personnelles et votre parcours universitaire. Nous vous souhaitons une bonne continuation.\n\ncordialement,\nl'équipe CNRST
            ''');
      RouteController.goTo(HomePage(), "home");
    } on Exception catch (e) {
      final snackBar = SnackBar(
        content: Text('Error sending email: $e'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw Exception('Error sending email: $e');
    }
  }

  void addIntern(BuildContext context, Intern intern) {
    try {
      if (_validateIntern(context, intern)) {
        acceptInternEmail(context, intern);
        _databaseRepository.insertIntern(intern);
        NotificationHelper().notify(
            title: 'Intern added',
            body: '${intern.name} is added successfully');
        DocumentGenerator().generateAndPrintPDF(intern);
        RouteController.goBack();
        RouteController.goTo(HomePage(), "home");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding intern: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
