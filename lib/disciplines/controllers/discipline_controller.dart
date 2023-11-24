import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:app_minhas_notas/disciplines/services/discipline_service.dart';
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

  DisciplineService get disciplineService =>
      ref.read(disciplineServiceProvider);
}

final disciplineControllerProvider =
    AsyncNotifierProvider<DisciplineController, List<Discipline>>(
        () => DisciplineController());
