import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:sparks/view/components/email_box.dart';

class EmailHelper {
  static Future<void> sendEmail({
    required String toEmail,
    String? subject,
    String? body,
  }) async {
    String username = 'yahya.elhilaly00@gmail.com';
    String password = 'orzk juyo bsqs lxcc';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'yahya')
      ..recipients.add(toEmail)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. Error: $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<bool> showEmailComposeDialog(
    BuildContext context, {
    required void Function(String subject, String body) onSend,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true, // force explicit Cancel / Send
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: EmailComposeBox(
            onSend: (sub, body) {
              Navigator.of(ctx).pop(true); // close first
              onSend(sub, body); // then execute caller’s callback
            },
          ),
        ),
      ),
    );
    return result ?? false;
  }
}
