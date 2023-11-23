import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';
import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AbstractDisciplineService {
  List<Discipline> disciplines = [];

  List<Discipline> addDiscipline(Discipline discipline);
  List<Discipline> updateDiscipline(Discipline discipline, int index);
  List<Discipline> removeDiscipline(Discipline discipline);
}

class DisciplineService extends AbstractDisciplineService {
  final DisciplineRepository disciplineRepository;

  DisciplineService({required this.disciplineRepository});

  @override
  List<Discipline> addDiscipline(Discipline discipline) {
    return disciplineRepository.addDiscipline(discipline);
  }

  @override
  List<Discipline> updateDiscipline(Discipline discipline, int index) {
    return disciplineRepository.updateDiscipline(discipline, index);
  }

  @override
  List<Discipline> removeDiscipline(Discipline discipline) {
    return disciplineRepository.removeDiscipline(discipline);
  }
}

final disciplineServiceProvider = Provider((ref) {
  final disciplineRepository = ref.watch(disciplineRepositoryProvider);
  return DisciplineService(disciplineRepository: disciplineRepository);
});
