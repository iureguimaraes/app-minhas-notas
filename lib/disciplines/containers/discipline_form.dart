import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActivityForm extends StatefulWidget {
  final String name;
  final double weight;
  final double grade;

  final ValueSetter<Activity> onChanged;

  const ActivityForm(
      {super.key,
      required this.name,
      required this.weight,
      required this.grade,
      required this.onChanged});

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.name;
    _weightController.text = widget.weight.toString();
    _gradeController.text = widget.grade.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Nome da atividade'),
            controller: _nameController,
            onChanged: (value) {
              widget.onChanged(getActivityFromForm());
            },
          ),
        ),
        SizedBox(width: 16),
        SizedBox(
          width: 80,
          child: TextField(
            decoration: InputDecoration(labelText: 'Peso'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            controller: _weightController,
            onChanged: (value) {
              widget.onChanged(getActivityFromForm());
            },
          ),
        ),
        SizedBox(width: 16),
        SizedBox(
          width: 80,
          child: TextField(
            decoration: InputDecoration(labelText: 'Nota'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            controller: _gradeController,
            onChanged: (value) {
              widget.onChanged(getActivityFromForm());
            },
          ),
        ),
      ],
    );
  }

  Activity getActivityFromForm() {
    return Activity(_nameController.text, double.parse(_weightController.text),
        double.parse(_gradeController.text));
  }
}

class DisciplineForm extends StatefulWidget {
  final ValueSetter<Discipline> onSubmit;
  final Discipline? discipline;
  final String action;

  const DisciplineForm(
      {super.key,
      this.discipline,
      required this.action,
      required this.onSubmit});

  @override
  State<DisciplineForm> createState() => _DisciplineFormState();
}

class _DisciplineFormState extends State<DisciplineForm> {
  TextEditingController _nameController = TextEditingController();
  List<Activity> activities = [];
  String submitButtonLabel = '';

  @override
  void initState() {
    _nameController.text = widget.discipline?.name ?? 'Nova Disciplina';
    activities = widget.discipline?.activities ?? [];
    submitButtonLabel = widget.action;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nome da disciplina'),
              controller: _nameController,
            ),
            Expanded(
                child: activities.isEmpty
                    ? Center(
                        child: Text('Nenhuma atividade adicionada'),
                      )
                    : ListView(
                        children: activities.map((activity) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            ActivityForm(
                              weight: activity.weight,
                              grade: activity.grade,
                              name: activity.name,
                              onChanged: (changed) {
                                activity.name = changed.name;
                                activity.grade = changed.grade;
                                activity.weight = changed.weight;
                              },
                            )
                          ],
                        );
                      }).toList())),
            SizedBox(height: 16),
            TextButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  setState(() {
                    activities.add(Activity('Nova Atividade', 0, 0));
                  });
                },
                child: Text('Adicionar Atividade')),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                widget.onSubmit(Discipline(_nameController.text, activities));
              },
              child: Text(submitButtonLabel),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }
}
