import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sparks/model/intern.dart';

class InternInfoTable extends StatelessWidget {
  final Intern intern;

  const InternInfoTable({Key? key, required this.intern}) : super(key: key);

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
    final startStr = DateFormat.yMMMd().format(intern.startDate);
    final endStr = intern.endDate != null
        ? DateFormat.yMMMd().format(intern.endDate!)
        : 'N/A';
    final supervisors =
        intern.supervisors.isNotEmpty ? intern.supervisors.join(', ') : 'N/A';

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
          verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        children: [
          _buildRow('Ref', intern.cin),
          _buildRow('Status', intern.status),
          _buildRow('Address', intern.address),
          _buildRow('Email', intern.email),
          _buildRow('Role', intern.role),
          _buildRow('Department', intern.department),
          _buildRow('Division', intern.division),
          _buildRow('Start Date', intern.startDate.toString()),
          _buildRow('End Date', intern.endDate.toString()),
          _buildRow('Supervisor(s)', intern.supervisors.toString()),
          _buildRow('Documents', 'N/A'),
          _buildRow('Insurance', 'N/A'),
        ],
      ),
    );
  }
}
