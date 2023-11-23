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

  void updateDiscipline(Discipline discipline, int index) {
    state = state.asMap().entries.map((entry) {
      Discipline d = entry.value;
      int i = entry.key;

      return index != i ? d : discipline;
    }).toList();
  }

  void removeDiscipline(Discipline discipline) {
    state = state.where((d) => d != discipline).toList();
  }
}

final disciplineRepositoryProvider =
    NotifierProvider<DisciplineRepository, List<Discipline>>(
        () => DisciplineRepository());
