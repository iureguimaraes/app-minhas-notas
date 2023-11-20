class Activity {
  String name;
  double weight;
  double grade;

  Activity(this.name, this.weight, this.grade);
}

class Discipline {
  String name;
  List<Activity> activities = [];

  Discipline(this.name, this.activities);
}
