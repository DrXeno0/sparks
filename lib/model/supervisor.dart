import 'package:isar/isar.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/supervisor_entity.dart' as entity;

class Supervisor {
  final int? id;
  final String name;
  final String role;
  final String department;
  final String division;
  final String cin;
  final Gender gender;

  final DateTime startDate;
  final String phone;
  final String email;
  final String address;
  List<int> supervisedInterns;

  Supervisor({
    this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.division,
    required this.cin,
    required this.gender,
    required this.startDate,
    required this.phone,
    required this.email,
    required this.address,
    this.supervisedInterns = const [],
  });

  /* ── utils ───────────────────────────────────────────── */

  Supervisor copyWith({
    int? id,
    String? name,
    String? role,
    String? department,
    String? division,
    String? cin,
    Gender? gender,
    DateTime? startDate,
    String? phone,
    String? email,
    String? address,
    List<int>? supervisedInterns,
  }) =>
      Supervisor(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        department: department ?? this.department,
        division: division ?? this.division,
        cin: cin ?? this.cin,
        gender: gender ?? Gender.unknown,
        startDate: startDate ?? this.startDate,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        address: address ?? this.address,
        supervisedInterns: supervisedInterns ?? this.supervisedInterns,
      );

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        id: json['id'] as int?,
        name: json['name'] as String,
        role: json['role'] as String,
        department: json['department'] as String,
        division: json['division'] as String,
        cin: json['cin'] as String,
        gender: Gender.values.firstWhere((e) => e.name == json['gender']),
        startDate: DateTime.parse(json['startDate'] as String),
        phone: json['phone'] as String,
        email: json['email'] as String,
        address: json['address'] as String,
        supervisedInterns: json['supervisedInterns'] as List<int>? ?? const [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'department': department,
        'division': division,
        'cin': cin,
        'gender': gender.name,
        'startDate': startDate.toIso8601String(),
        'phone': phone,
        'email': email,
        'address': address,
        'supervisedInternCount': supervisedInterns,
      };

  entity.Supervisor toEntity() {
    final _entity = entity.Supervisor();
    this.id == null ? _entity.id : _entity.id = this.id as Id;
    _entity.name = this.name;
    _entity.role = this.role;
    _entity.department = this.department;
    _entity.division = this.division;
    _entity.cin = this.cin;
    _entity.gender = this.gender;
    _entity.startDate = this.startDate;
    _entity.phone = this.phone;
    _entity.email = this.email;
    _entity.address = this.address;
    _entity.supervisedInterns =
        this.supervisedInterns.map((e) => e as Id).toList();
    return _entity;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Supervisor && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
