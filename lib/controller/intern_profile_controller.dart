import 'package:flutter/material.dart';
import 'package:sparks/model/intern.dart';
import 'package:sparks/nav_system/my_custome_nav.dart';
import 'package:sparks/repository/database_repository.dart';
import 'package:sparks/utils/confirmation_helper.dart' as ConfirmationHelper;
import 'package:sparks/utils/email_helper.dart';

class InternProfileController {
  final DatabaseRepository _databaseRepository = DatabaseRepository();

  Future<void> deleteIntern(BuildContext context, Intern intern) async {
    if (await ConfirmationHelper.confirmDelete(
        context,
        'Delete Intern',
        'Are you sure you want to delete ${intern.name}?',
        'Delete',
        Colors.red)) {
      _databaseRepository.deleteIntern(intern);
      print('✅ Intern deleted successfully');
      RouteController.goBack();
    }
  }

  void sendEmail(String to, String subject, String body) {
    EmailHelper.sendEmail(toEmail: to, subject: subject, body: body);
  }
}
