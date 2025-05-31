import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sparks/model/supervisor.dart';

class SupervisorInfoTable extends StatelessWidget {
  final Supervisor supervisor;

  const SupervisorInfoTable({Key? key, required this.supervisor})
      : super(key: key);

  /* ── helpers ─────────────────────────────────────────── */

  TableRow _buildRow(String label, String value) => TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(value),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    final startStr = DateFormat.yMMMd().format(supervisor.startDate);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Table(
        columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
          verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        children: [
          _buildRow('Name', supervisor.name),
          _buildRow('Role', supervisor.role),
          _buildRow('Department', supervisor.department),
          _buildRow('Start Date', startStr),
          _buildRow('Phone', supervisor.phone),
          _buildRow('Email', supervisor.email),
          _buildRow('Address', supervisor.address),
          _buildRow('Supervised Interns',
              supervisor.supervisedInterns.length.toString()),
        ],
      ),
    );
  }
}
