import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:app_minhas_notas/recomendations/models/recomendations.dart';
import 'package:app_minhas_notas/recomendations/repositories/recomendation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AbstractRecomendationService {
  Future<List<Recomendation>> getRecomendations();
  Future<void> saveRecomendation(Discipline discipline, String description);
}

class RecomendationService extends AbstractRecomendationService {
  final RecomendationRepository recomendationRepository;

  RecomendationService({required this.recomendationRepository});

  @override
  Future<List<Recomendation>> getRecomendations() async {
    return recomendationRepository.getRecomendations();
  }

  @override
  Future<void> saveRecomendation(
      Discipline discipline, String description) async {
    await recomendationRepository.saveRecomendation(
        Recomendation(discipline: discipline, description: description));
  }
}

final recomendationServiceProvider = Provider((ref) {
  final recomendationRepository = ref.watch(recomendationRepositoryProvider);
  return RecomendationService(recomendationRepository: recomendationRepository);
});
