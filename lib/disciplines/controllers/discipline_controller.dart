import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:app_minhas_notas/disciplines/services/discipline_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisciplineController extends Notifier<List<Discipline>> {
  @override
  build() {
    return [];
  }

  void addDiscipline(Discipline discipline) {
    state = disciplineService.addDiscipline(discipline);
  }

  void updateDiscipline(Discipline discipline, int index) {
    state = disciplineService.updateDiscipline(discipline, index);
  }

  void removeDiscipline(Discipline discipline) {
    state = disciplineService.removeDiscipline(discipline);
  }

  DisciplineService get disciplineService =>
      ref.read(disciplineServiceProvider);
}

final disciplineControllerProvider =
    NotifierProvider<DisciplineController, List<Discipline>>(
        () => DisciplineController());
