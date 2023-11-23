import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AbstractDisciplineRepository {
  List<Discipline> disciplines = [];

  List<Discipline> addDiscipline(Discipline discipline);
  List<Discipline> updateDiscipline(Discipline discipline, int index);
  List<Discipline> removeDiscipline(Discipline discipline);
}

class DisciplineRepository extends AbstractDisciplineRepository {
  @override
  List<Discipline> addDiscipline(Discipline discipline) {
    disciplines = [...disciplines, discipline];
    return disciplines;
  }

  @override
  List<Discipline> updateDiscipline(Discipline discipline, int index) {
    disciplines = disciplines.asMap().entries.map((entry) {
      Discipline d = entry.value;
      int i = entry.key;

      return index != i ? d : discipline;
    }).toList();
    return disciplines;
  }

  @override
  List<Discipline> removeDiscipline(Discipline discipline) {
    disciplines = disciplines.where((d) => d != discipline).toList();
    return disciplines;
  }
}

final disciplineRepositoryProvider = Provider((ref) => DisciplineRepository());
