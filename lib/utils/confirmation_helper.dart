import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> confirmDelete(BuildContext context,String title, String message,  String buttonName, Color buttonColor) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false, // force an explicit choice
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      title: Text(title),
      content: Text(
        message,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(ctx).pop(false),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
          ),
          child: Text(buttonName),
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
  return result ?? false;
}
