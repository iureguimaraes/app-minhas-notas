import 'package:app_minhas_notas/disciplines/pages/add_discipline.dart';
import 'package:flutter/material.dart';

class DisciplinesList extends StatelessWidget {
  const DisciplinesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas Disciplinas')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Clique no botão + para adicionar uma nova disciplina',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDisciplinePage(),
            ),
          );
        },
        tooltip: 'Adicionar disciplina',
        child: const Icon(Icons.add),
      ),
    );
  }
}
