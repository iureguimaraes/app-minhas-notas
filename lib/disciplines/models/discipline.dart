class Activity {
  int? id;
  int? disciplineId;
  double weight;
  double grade;
  String name;

  Activity(this.name, this.weight, this.grade, {this.id, this.disciplineId});

  String get description => 'Peso: $weight | Nota: $grade';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'discipline_id': disciplineId,
      'name': name,
      'weight': weight,
      'grade': grade,
    };
  }

  static Activity fromJson(dynamic data) {
    return Activity(
      data['name'],
      data['weight'],
      data['grade'],
      id: data['id'],
      disciplineId: data['discipline_id'],
    );
  }

  Activity clone() {
    return Activity(
      name,
      weight,
      grade,
      id: id,
      disciplineId: disciplineId,
    );
  }
}

class Discipline {
  int? id;
  String name;
  List<Activity> activities = [];

  Discipline(this.name, this.activities);

  String getDescription() {
    if (activities.isEmpty) {
      return "Sem atividades";
    } else {
      final weights = activities.fold(
          0.0, (weightSum, element) => weightSum + element.weight);
      final currentGrade = activities.fold(
              0.0,
              (gradeSum, element) =>
                  gradeSum + (element.weight * element.grade)) /
          weights;

      return "${activities.map((activity) => '${activity.name}: ${activity.grade}').join(", ")}${weights > 0 ? "\nMédia Atual: $currentGrade." : "\nNenhum peso cadastrado."}";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'activities': activities.map((e) => e.toMap()).toList(),
    };
  }

  static Discipline fromJson(dynamic data) {
    return Discipline(
      data['name'],
      List.from(data['activities']).map((e) => Activity.fromJson(e)).toList(),
    );
  }

  Discipline clone() {
    return Discipline(
      name,
      activities.map((activity) => activity.clone()).toList(),
    );
  }
}
