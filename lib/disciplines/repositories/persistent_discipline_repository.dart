import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';
import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PersistentDisciplineRepository extends DisciplineRepository {
  static Database? _database;

  @override
  Future<List<Discipline>> getDisciplines() async {
    return _getAllDisciplinesFromDatabase();
  }

  @override
  Future<Discipline> addDiscipline(Discipline discipline) async {
    Discipline insertedDiscipline = await _addDisciplineToDatabase(discipline);
    return insertedDiscipline;
  }

  @override
  Future<Discipline> updateDiscipline(Discipline discipline, int index) async {
    await _removeDisciplineFromDatabase(discipline);
    await _addDisciplineToDatabase(discipline);
    return discipline;
  }

  @override
  Future<bool> removeDiscipline(Discipline discipline) async {
    return _removeDisciplineFromDatabase(discipline);
  }

  Future<Discipline> _addDisciplineToDatabase(Discipline discipline) async {
    final db = await database;

    int id = await db.insert(
      'disciplines',
      discipline.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (int i = 0; i < discipline.activities.length; i++) {
      discipline.activities[i].disciplineId = id;
      discipline.activities[i].disciplineId = id;

      db.insert(
        'activities',
        discipline.activities[i].toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    discipline.id = id;
    return discipline;
  }

  Future<bool> _removeDisciplineFromDatabase(Discipline discipline) async {
    final db = await database;
    if (discipline.id != null) {
      await db.delete(
        'disciplines',
        where: 'id = ?',
        whereArgs: [discipline.id],
      );

      await db.delete(
        'activities',
        where: 'discipline_id = ?',
        whereArgs: [discipline.id],
      );
    }

    return true;
  }

  Future<List<Discipline>> _getAllDisciplinesFromDatabase() async {
    List<Discipline> disciplines = [];

    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('disciplines');

    for (int i = 0; i < results.length; i++) {
      List<Activity> activities =
          await _getAllActivitiesOfDiscipline(results[i]['id']);

      Discipline discipline = Discipline(results[i]['name'], activities);
      discipline.id = results[i]['id'];
      disciplines.add(discipline);
    }
    return disciplines;
  }

  Future<List<Activity>> _getAllActivitiesOfDiscipline(int disciplineId) async {
    List<Activity> activities = [];
    final db = await database;

    final List<Map<String, dynamic>> results = await db.query('activities',
        where: 'discipline_id = ?', whereArgs: [disciplineId]);

    for (int i = 0; i < results.length; i++) {
      Activity activity = Activity(
          results[i]['name'], results[i]['weight'], results[i]['grade']);
      activity.disciplineId = disciplineId;
      activities.add(activity);
    }

    return activities;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'disciplines.db'),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE disciplines (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT
          )
        ''');

        db.execute('''
          CREATE TABLE activities (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            discipline_id INTEGER NOT NULL,
            name TEXT,
            weight REAL,
            grade REAL
          )
        ''');
      },
      version: 1,
    );
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
}
