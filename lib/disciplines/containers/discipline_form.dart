import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter/material.dart';

class ActivityForm extends StatefulWidget {
  final ValueSetter<Activity> onChanged;
  final GlobalKey<FormState> formKey;
  final Activity activity;

  const ActivityForm(
      {super.key,
      required this.activity,
      required this.formKey,
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
    _nameController.text = widget.activity.name;
    _weightController.text = widget.activity.weight.toString();
    _gradeController.text = widget.activity.grade.toString();

    super.initState();
  }

  Activity getActivityFromControllers() {
    return Activity(_nameController.text, double.parse(_weightController.text),
        double.parse(_gradeController.text));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400,
        child: Form(
          onChanged: () {
            widget.onChanged(getActivityFromControllers());
          },
          key: widget.formKey,
          child: Wrap(
            spacing: 8,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome da atividade'),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um nome para a atividade';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Peso'),
                controller: _weightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um peso para a atividade';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nota'),
                controller: _gradeController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityListTile extends StatefulWidget {
  final ValueSetter<Activity> onChanged;
  final ValueGetter onDeleted;
  final Activity activity;

  const ActivityListTile(
      {super.key,
      required this.activity,
      required this.onChanged,
      required this.onDeleted});

  @override
  State<ActivityListTile> createState() => _ActivityListTileState();
}

class _ActivityListTileState extends State<ActivityListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.activity.name),
        subtitle: Text(widget.activity.description),
        trailing: Wrap(
          children: [
            IconButton(
                onPressed: () {
                  final formKey = GlobalKey<FormState>();
                  Activity activityFormState = widget.activity;

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Editar Atividade'),
                        content: ActivityForm(
                            activity: widget.activity,
                            formKey: formKey,
                            onChanged: (activity) {
                              activityFormState = activity;
                            }),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                widget.onChanged(activityFormState);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  widget.onDeleted();
                },
                icon: Icon(Icons.delete)),
          ],
        ));
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
                            ActivityListTile(
                              activity: activity,
                              onChanged: (changed) {
                                setState(() {
                                  activity.weight = changed.weight;
                                  activity.grade = changed.grade;
                                  activity.name = changed.name;
                                });
                              },
                              onDeleted: () {
                                setState(() {
                                  activities.remove(activity);
                                });
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
