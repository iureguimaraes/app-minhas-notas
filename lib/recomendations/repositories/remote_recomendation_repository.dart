import 'package:app_minhas_notas/recomendations/models/recomendations.dart';
import 'package:app_minhas_notas/recomendations/repositories/recomendation_repository.dart';
import 'package:dio/dio.dart';

class RemoteRecomendationRepository extends RecomendationRepository {
  final String baseUrl = 'https://6560e2c583aba11d99d1aa2f.mockapi.io/api/v1';
  final Dio dio;

  RemoteRecomendationRepository({required this.dio});

  @override
  Future<List<Recomendation>> getRecomendations() async {
    final response = await dio.get('$baseUrl/recomendations');
    return List.from(response.data)
        .map((e) => Recomendation.fromJson(e))
        .toList();
  }

  @override
  Future<void> saveRecomendation(Recomendation recomentation) async {
    await dio.post('$baseUrl/recomendations', data: recomentation.toJson());
  }
}
