import 'package:app_minhas_notas/disciplines/containers/discipline_form.dart';
import 'package:flutter/material.dart';

class AddDisciplinePage extends StatefulWidget {
  const AddDisciplinePage({super.key});

  @override
  State<AddDisciplinePage> createState() => _AddDisciplinePageState();
}

class _AddDisciplinePageState extends State<AddDisciplinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Disciplina')),
      body: Center(
          child: DisciplineForm(
        action: 'Adicionar Disciplina',
        onSubmit: (discipline) {
          print(discipline);
        },
      )),
    );
  }
}
