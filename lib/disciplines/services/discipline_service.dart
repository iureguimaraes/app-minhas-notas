import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';
import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AbstractDisciplineService {
  Future<List<Discipline>> getAllDisciplines();
  Future<Discipline> addDiscipline(Discipline discipline);
  Future<Discipline> updateDiscipline(Discipline discipline, int index);
  Future<bool> removeDiscipline(Discipline discipline);
}

class DisciplineService extends AbstractDisciplineService {
  final DisciplineRepository disciplineRepository;

  DisciplineService({required this.disciplineRepository});

  @override
  Future<List<Discipline>> getAllDisciplines() {
    return disciplineRepository.getDisciplines();
  }

  @override
  Future<Discipline> addDiscipline(Discipline discipline) {
    return disciplineRepository.addDiscipline(discipline);
  }

  @override
  Future<Discipline> updateDiscipline(Discipline discipline, int index) {
    return disciplineRepository.updateDiscipline(discipline, index);
  }

  @override
  Future<bool> removeDiscipline(Discipline discipline) {
    return disciplineRepository.removeDiscipline(discipline);
  }
}

final disciplineServiceProvider = Provider((ref) {
  final disciplineRepository = ref.watch(disciplineRepositoryProvider);
  return DisciplineService(disciplineRepository: disciplineRepository);
});
