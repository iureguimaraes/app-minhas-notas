import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisciplineRepository extends Notifier<List<Discipline>> {
  @override
  build() {
    return [];
  }

  void addDiscipline(Discipline discipline) {
    state = [...state, discipline];
  }

  void removeDiscipline(Discipline discipline) {
    state = state.where((d) => d.name != discipline.name).toList();
  }
}

final disciplineRepositoryProvider =
    NotifierProvider<DisciplineRepository, List<Discipline>>(
        () => DisciplineRepository());
