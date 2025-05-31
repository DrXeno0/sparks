import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sparks/model/intern.dart' as intern;
import 'package:sparks/model/intern_entity.dart';
import 'package:sparks/model/supervisor_entity.dart';

class DatabaseRepository {
  static final DatabaseRepository _instance = DatabaseRepository._internal();

  static late final Isar db;
  static bool _isInitialized = false;

  // Private constructor
  DatabaseRepository._internal();

  // Factory constructor to return the same instance
  factory DatabaseRepository() => _instance;

  // Call this once before using the repository
  Future<void> init() async {
    if (!_isInitialized) {
      db = await _dbInit();
      _isInitialized = true;
    }
  }

  static Future<Isar> _dbInit() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [SupervisorSchema, InternSchema],
      directory: dir.path,
    );
  }

  // All your existing methods stay the same
  Future<void> insertIntern(intern.Intern intern) async {
    final internEntity = intern.toEntity();
    await db.writeTxn(() async {
      await db.interns.put(internEntity);
    });
    print('✅ Intern inserted successfully');
  }

  Future<void> updateIntern(intern.Intern intern) async {
    final internEntity = intern.toEntity();
    await db.writeTxn(() async {
      await db.interns.put(internEntity);
    });
  }

  Future<void> deleteIntern(intern.Intern intern) async {
    print(intern.id);
    final internEntity = intern.toEntity();
    await db.writeTxn(() async {
      print(internEntity.id);
      await db.interns.delete(internEntity.id);
    });
  }

  Future<List<intern.Intern>> getAllInterns() async {
    final internEntities = await db.interns.where().findAll();
    return internEntities.map((e) => e.toIntern()).toList();
  }

  Future<intern.Intern?> getInternById(String id) async {
    final internEntity = await db.interns.get(id as Id);
    return internEntity?.toIntern();
  }

  Future<intern.Intern?> getInternByName(String name) async {
    final internEntity =
        await db.interns.filter().nameEqualTo(name).findFirst();
    return internEntity?.toIntern();
  }

  Future<List<intern.Intern>> searchInterns(String query) async {
    final internEntities = await db.interns
        .filter()
        .nameContains(query)
        .or()
        .refContains(query)
        .or()
        .addressContains(query)
        .or()
        .emailContains(query)
        .or()
        .phoneContains(query)
        .or()
        .roleContains(query)
        .or()
        .departmentContains(query)
        .or()
        .divisionContains(query)
        .findAll();

    return internEntities.map((e) => e.toIntern()).toList();
  }

  Future<List<intern.Intern>> getInternsBySupervisor(
      String supervisorId) async {
    final internEntities = await db.interns
        .filter()
        .supervisorsElementEqualTo(supervisorId as Id)
        .findAll();

    return internEntities.map((e) => e.toIntern()).toList();
  }

  Future<void> close() async {
    await db.close();
    _isInitialized = false;
  }
}
