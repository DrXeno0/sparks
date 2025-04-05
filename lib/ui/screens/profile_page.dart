import 'package:flutter/cupertino.dart';

class ProfilePage extends StatelessWidget {
  final String internId;

  const ProfilePage({super.key, required this.internId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Intern Profile: $internId"),
    );
  }
}