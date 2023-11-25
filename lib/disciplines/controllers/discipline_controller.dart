import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:app_minhas_notas/disciplines/services/discipline_service.dart';
import 'package:app_minhas_notas/recomendations/services/recomendation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisciplineController extends AsyncNotifier<List<Discipline>> {
  @override
  Future<List<Discipline>> build() {
    return disciplineService.getAllDisciplines();
  }

  void addDiscipline(Discipline discipline) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await disciplineService.addDiscipline(discipline);
      return disciplineService.getAllDisciplines();
    });
  }

  void updateDiscipline(Discipline discipline, int index) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await disciplineService.updateDiscipline(discipline, index);
      return disciplineService.getAllDisciplines();
    });
  }

  void removeDiscipline(Discipline discipline) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await disciplineService.removeDiscipline(discipline);
      return disciplineService.getAllDisciplines();
    });
  }

  void share(Discipline discipline, String description) async {
    discipline.id = null;
    for (int i = 0; i < discipline.activities.length; i++) {
      discipline.activities[i].disciplineId = null;
      discipline.activities[i].grade = 0;
      discipline.activities[i].id = null;
    }

    await recomendationService.saveRecomendation(discipline, description);
  }

  DisciplineService get disciplineService =>
      ref.read(disciplineServiceProvider);

  RecomendationService get recomendationService =>
      ref.read(recomendationServiceProvider);
}

final disciplineControllerProvider =
    AsyncNotifierProvider<DisciplineController, List<Discipline>>(
        () => DisciplineController());
