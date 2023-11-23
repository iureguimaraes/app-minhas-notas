import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:app_minhas_notas/disciplines/containers/discipline_form.dart';
import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';

class AddDisciplinePage extends ConsumerStatefulWidget {
  const AddDisciplinePage({super.key});

  @override
  AddDisciplinePageState createState() => AddDisciplinePageState();
}

class AddDisciplinePageState extends ConsumerState<AddDisciplinePage> {
  @override
  Widget build(BuildContext context) {
    final disciplineRepository =
        ref.read(disciplineRepositoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Disciplina')),
      body: Center(
          child: DisciplineForm(
        action: 'Adicionar Disciplina',
        onSubmit: (discipline) {
          disciplineRepository.addDiscipline(discipline);
          Navigator.pop(context);
        },
      )),
    );
  }
}
