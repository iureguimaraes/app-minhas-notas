import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';

class TemporaryDisciplineRepository extends DisciplineRepository {
  List<Discipline> disciplines = [];

  @override
  Future<List<Discipline>> getDisciplines() async {
    return disciplines;
  }

  @override
  Future<Discipline> addDiscipline(Discipline discipline) async {
    disciplines = [...disciplines, discipline];
    return discipline;
  }

  @override
  Future<Discipline> updateDiscipline(Discipline discipline, int index) async {
    disciplines = disciplines.asMap().entries.map((entry) {
      Discipline d = entry.value;
      int i = entry.key;

      return index != i ? d : discipline;
    }).toList();

    return discipline;
  }

  @override
  Future<bool> removeDiscipline(Discipline discipline) async {
    disciplines = disciplines.where((d) => d != discipline).toList();
    return true;
  }
}
