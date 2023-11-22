import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:app_minhas_notas/disciplines/containers/discipline_form.dart';
import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';

class EditDisciplinePage extends ConsumerStatefulWidget {
  final Discipline discipline;
  final int index;

  const EditDisciplinePage(
      {super.key, required this.discipline, required this.index});

  @override
  EditDisciplinePageState createState() => EditDisciplinePageState();
}

class EditDisciplinePageState extends ConsumerState<EditDisciplinePage> {
  @override
  Widget build(BuildContext context) {
    final disciplineRepository =
        ref.read(disciplineRepositoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Editar Disciplina')),
      body: Center(
          child: DisciplineForm(
        discipline: widget.discipline,
        action: 'Salvar Edições',
        onSubmit: (discipline) {
          disciplineRepository.updateDiscipline(discipline, widget.index);
          Navigator.pop(context);
        },
      )),
    );
  }
}
