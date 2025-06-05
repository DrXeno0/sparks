import 'package:isar/isar.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/supervisor.dart' as supervisor;

part 'supervisor_entity.g.dart';

@collection
class Supervisor {
  Id id = Isar.autoIncrement;
  late String name;
  late String role;
  late String department;
  late String division;
  late String cin;
  @enumerated
  late Gender gender;
  late DateTime startDate;
  late String phone;
  late String email;
  late String address;
  late List<Id> supervisedInterns;

  supervisor.Supervisor toSupervisor() {
    return supervisor.Supervisor(
        id: this.id.toInt(),
        name: this.name,
        role: this.role,
        department: this.department,
        division: this.division,
        cin: this.cin,
        gender: this.gender,
        startDate: this.startDate,
        phone: this.phone,
        email: this.email,
        address: this.address,
        supervisedInterns:
            this.supervisedInterns.map((e) => e.toInt()).toList());
  }
}
