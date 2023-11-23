class Activity {
  String name;
  double weight;
  double grade;

  Activity(this.name, this.weight, this.grade);
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
      final finalGrade = activities.fold(
              0.0,
              (gradeSum, element) =>
                  gradeSum + (element.weight * element.grade)) /
          weights;

      return "${activities.map((activity) => '${activity.name}: ${activity.grade}').join(", ")} | Nota: $finalGrade";
    }
  }
}
