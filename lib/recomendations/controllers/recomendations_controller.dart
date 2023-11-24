import 'package:app_minhas_notas/recomendations/models/recomendations.dart';
import 'package:app_minhas_notas/recomendations/services/recomendation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecomendationController extends AsyncNotifier<List<Recomendation>> {
  @override
  Future<List<Recomendation>> build() async {
    return recomendationService.getRecomendations();
  }

  refresh() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return recomendationService.getRecomendations();
    });
  }

  RecomendationService get recomendationService =>
      ref.read(recomendationServiceProvider);
}

final recomendationControllerProvider =
    AsyncNotifierProvider<RecomendationController, List<Recomendation>>(
        () => RecomendationController());
