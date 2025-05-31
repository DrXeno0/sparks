import 'package:isar/isar.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/intern_entity.dart' as InternEntity;

class Intern {
  final int? id;
  final String name;
  final String role;
  final String ref;
  final String phone;
  final Gender gender;
  final String department;
  final String division;
  final DateTime startDate;
  final DateTime? endDate;
  final String cin;
  final String address;
  final String email;
  final String status; // e.g., Active, Finished, On-Hold
  final List<int> supervisors; // supervisor IDs

  const Intern(
      {this.id,
      required this.name,
      required this.role,
      required this.ref,
      required this.phone,
      required this.gender,
      required this.department,
      required this.division,
      required this.startDate,
      this.endDate,
      required this.cin,
      required this.address,
      required this.email,
      this.status = 'Active',
      this.supervisors = const []});

  /* ── utils ───────────────────────────────────────────── */

  Intern copyWith({
    String? id,
    String? name,
    String? role,
    String? ref,
    String? phone,
    Gender? gender,
    String? department,
    String? division,
    DateTime? startDate,
    DateTime? endDate,
    String? cin,
    String? address,
    String? email,
    String? status,
    List<int>? supervisors,
  }) =>
      Intern(
        id: this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        ref: ref ?? this.ref,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        department: department ?? this.department,
        division: division ?? this.division,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        cin: cin ?? this.cin,
        address: address ?? this.address,
        email: email ?? this.email,
        status: status ?? this.status,
        supervisors: supervisors ?? List<int>.from(this.supervisors),
      );

  factory Intern.fromJson(Map<String, dynamic> json) => Intern(
        id: json['id'] as int,
        name: json['name'] as String,
        role: json['role'] as String,
        ref: json['ref'] as String,
        phone: json['phone'] as String,
        gender: Gender.values.firstWhere((e) => e.name == json['gender']),
        department: json['department'] as String,
        division: json['division'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate:
            json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
        cin: json['cin'] as String,
        address: json['address'] as String,
        email: json['email'] as String,
        status: json['status'] as String? ?? 'Active',
        supervisors: (json['supervisors'] as List<int>? ?? const [])
            .map((e) => e)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'ref': ref,
        'phone': phone,
        'gender': gender.name,
        'department': department,
        'division': division,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        "cin": cin,
        'address': address,
        'email': email,
        'status': status,
        'supervisors': supervisors,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Intern && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String? get imageUrl => null;

  InternEntity.Intern toEntity() {
    final entity = InternEntity.Intern();
    this.id == null ? entity.id : entity.id = this.id as Id;
    entity.name = this.name;
    entity.role = this.role;
    entity.ref = this.ref;
    entity.phone = this.phone;
    entity.gender = this.gender;
    entity.department = this.department;
    entity.division = this.division;
    entity.startDate = this.startDate;
    entity.endDate = this.endDate;
    entity.cin = this.cin;
    entity.address = this.address;
    entity.email = this.email;
    entity.status = this.status;
    entity.supervisors = this.supervisors.map((e) => e as Id).toList();
    return entity;
  }
}
