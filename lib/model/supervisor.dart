class Supervisor {
  final String id;
  final String name;
  final String role;
  final String department;
  final DateTime startDate;
  final String phone;
  final String email;
  final String address;
  List<int> supervisedInterns;

  Supervisor({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.startDate,
    required this.phone,
    required this.email,
    required this.address,
    this.supervisedInterns = const [],
  });

  /* ── utils ───────────────────────────────────────────── */

  Supervisor copyWith({
    String? id,
    String? name,
    String? role,
    String? department,
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
        startDate: startDate ?? this.startDate,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        address: address ?? this.address,
        supervisedInterns: supervisedInterns ?? this.supervisedInterns,
      );

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        id: json['id'] as String,
        name: json['name'] as String,
        role: json['role'] as String,
        department: json['department'] as String,
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
        'startDate': startDate.toIso8601String(),
        'phone': phone,
        'email': email,
        'address': address,
        'supervisedInternCount': supervisedInterns,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Supervisor && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
