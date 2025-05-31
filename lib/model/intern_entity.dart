import 'package:isar/isar.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/intern.dart' as intern;

part 'intern_entity.g.dart';

@collection
class Intern {
  Id id = Isar.autoIncrement;
  late String name;
  late String role;
  late String ref;
  late String phone;

  @enumerated
  late Gender gender;
  late String department;
  late String division;
  late DateTime startDate;
  DateTime? endDate;
  late String cin;
  late String address;
  late String email;
  late String status;
  late List<Id> supervisors;

  intern.Intern toIntern() {
    final intern1 = intern.Intern(
        id: this.id.toInt(),
        name: this.name,
        role: this.role,
        ref: this.ref,
        phone: this.phone,
        gender: this.gender,
        department: this.department,
        division: this.division,
        startDate: this.startDate,
        endDate: this.endDate,
        cin: this.cin,
        address: this.address,
        email: this.email,
        status: this.status,
        supervisors: this.supervisors.map((e) => e.toInt()).toList());

    return intern1;
  }
}
