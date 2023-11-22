import 'package:app_minhas_notas/disciplines/pages/add_discipline.dart';
import 'package:app_minhas_notas/disciplines/pages/edit_discipline.dart';
import 'package:app_minhas_notas/disciplines/repositories/discipline_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisciplinesList extends ConsumerWidget {
  const DisciplinesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disciplines = ref.watch(disciplineRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Minhas Disciplinas')),
      body: Center(
        child: disciplines.isEmpty
            ? Text(
                'Clique no botão + para adicionar uma nova disciplina',
              )
            : (ListView(
                children: [
                  for (var discipline in disciplines)
                    ListTile(
                      title: Text(discipline.name),
                      subtitle: Text(discipline.getDescription()),
                      trailing: Wrap(spacing: 4, children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDisciplinePage(
                                        discipline: discipline,
                                        index: disciplines.indexOf(discipline),
                                      )),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(disciplineRepositoryProvider.notifier)
                                .removeDiscipline(discipline);
                          },
                        )
                      ]),
                    )
                ],
              )),
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
