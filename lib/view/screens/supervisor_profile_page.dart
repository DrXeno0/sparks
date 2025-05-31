import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/profile_card_model.dart';
import 'package:sparks/model/supervisor.dart';
import 'package:sparks/view/components/supervisor_info_table.dart';

class SupervisorProfilePage extends StatelessWidget {
  final ProfileCardInfo profile;

  const SupervisorProfilePage({super.key, required this.profile});

  /* ── helpers ─────────────────────────────────────────── */

  String _getInitials(String name) {
    final parts = name.split(' ');
    return (parts.length >= 2 ? parts[0][0] + parts[1][0] : name[0])
        .toUpperCase();
  }

  Color _generateRandomColor(String seed) {
    final hash = seed.hashCode;
    return Color((hash & 0xFFFFFF) | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* ── avatar ──────────────────────────────────── */
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              // Add padding to avoid overlap with status bar
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: _generateRandomColor(profile.name),
                  backgroundImage: (profile.imageUrl?.isNotEmpty ?? false)
                      ? AssetImage(profile.imageUrl!) as ImageProvider
                      : null,
                  child: (profile.imageUrl == null || profile.imageUrl!.isEmpty)
                      ? Text(
                          _getInitials(profile.name),
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /* ── name & division ────────────────────────── */
            Text(
              profile.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Division: ${profile.division}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            /* ── gender icon (enum-aware) ───────────────── */
            SvgPicture.asset(profile.gender.assetPath(), width: 32),
            const SizedBox(height: 20),

            /* ── details table ─────────────────────────── */
            SupervisorInfoTable(
              supervisor: Supervisor(
                id: 'sup-001',
                name: profile.name,
                role: 'Role N/A',
                department: 'Department N/A',
                startDate: DateTime(2009, DateTime.march, 17),
                phone: 'N/A',
                email: 'N/A',
                address: 'N/A',
                supervisedInterns: const [34, 45, 2],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
