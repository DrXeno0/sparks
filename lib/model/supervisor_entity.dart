import 'package:isar/isar.dart';
import 'package:sparks/model/gender.dart';

part 'supervisor_entity.g.dart';

@collection
class supervisor {
  Id id = Isar.autoIncrement;
  late String name;
  late String role;
  late String department;
  @enumerated
  late Gender gender;
  late DateTime startDate;
  late String phone;
  late String email;
  late String address;
  late List<Id> supervisedInterns;
}
