import 'package:app_minhas_notas/disciplines/models/discipline.dart';

class Recomendation {
  Discipline discipline;
  String description;

  Recomendation({required this.discipline, required this.description});

  static Recomendation fromJson(dynamic data) {
    return Recomendation(
        discipline: Discipline.fromJson(data['discipline']),
        description: data['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'discipline': discipline.toJson(),
      'description': description,
    };
  }
}
