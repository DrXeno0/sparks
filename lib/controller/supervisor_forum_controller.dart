import 'package:flutter/material.dart';
import 'package:sparks/controller/form_validation_controller.dart';
import 'package:sparks/model/supervisor.dart';
import 'package:sparks/repository/database_repository.dart';

class SupervisorForumController extends ForumValidationController {
  final DatabaseRepository _databaseRepository = DatabaseRepository();

  bool _validateIntern(BuildContext context, Supervisor supervisor) {
    if (!validateEmail(supervisor.email)) {
      final snackBar = SnackBar(
        content: Text('Invalid email address.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }
    if (!validatePhone(supervisor.phone)) {
      final snackBar = SnackBar(
        content: Text('Invalid phone number.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }
    if (!validateName(supervisor.name)) {
      final snackBar = SnackBar(
        content: Text('Invalid name.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateAddress(supervisor.address)) {
      final snackBar = SnackBar(
        content: Text('Invalid address.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateID(supervisor.cin)) {
      final snackBar = SnackBar(
        content: Text('Invalid id'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateDivision(supervisor.division)) {
      final snackBar = SnackBar(
        content: Text('Invalid division.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!validateDepartment(supervisor.department)) {
      final snackBar = SnackBar(
        content: Text('Invalid department.'),
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  void addSupervisor(BuildContext context, Supervisor supervisor) {
    try {
      if (_validateIntern(context, supervisor)) {
        _databaseRepository.insertSupervisor(supervisor);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding supervisor: $e'),
          backgroundColor: Colors.red,
        ),
      );
      throw Exception('Error adding supervisor: $e');
    }
  }
}
