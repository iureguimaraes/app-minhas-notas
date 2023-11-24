import 'package:app_minhas_notas/recomendations/repositories/remote_recomendation_repository.dart';
import 'package:app_minhas_notas/recomendations/models/recomendations.dart';
import 'package:app_minhas_notas/shared/providers/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class RecomendationRepository {
  Future<List<Recomendation>> getRecomendations();
  Future<void> saveRecomendation(Recomendation recomentation);
}

final recomendationRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return RemoteRecomendationRepository(dio: dio);
});
