import 'package:app_minhas_notas/disciplines/repositories/persistent_discipline_repository.dart';
import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DisciplineRepository {
  Future<List<Discipline>> getDisciplines();
  Future<Discipline> addDiscipline(Discipline discipline);
  Future<Discipline> updateDiscipline(Discipline discipline, int index);
  Future<bool> removeDiscipline(Discipline discipline);
}

final disciplineRepositoryProvider =
    Provider((ref) => PersistentDisciplineRepository());
