import 'package:app_minhas_notas/disciplines/controllers/discipline_controller.dart';
import 'package:app_minhas_notas/disciplines/containers/share_discipline_form.dart';
import 'package:app_minhas_notas/disciplines/pages/edit_discipline.dart';
import 'package:app_minhas_notas/disciplines/pages/add_discipline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class DisciplinesList extends ConsumerWidget {
  const DisciplinesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disciplines = ref.watch(disciplineControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Minhas Disciplinas')),
      body: disciplines.when(
          data: (disciplines) => Center(
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
                                          builder: (context) =>
                                              EditDisciplinePage(
                                                discipline: discipline,
                                                index: disciplines
                                                    .indexOf(discipline),
                                              )),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    ref
                                        .read(disciplineControllerProvider
                                            .notifier)
                                        .removeDiscipline(discipline);
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          enableDrag: true,
                                          builder: (BuildContext bc) =>
                                              ShareDisciplineForm(
                                                discipline: discipline,
                                                onSubmit: (String description) {
                                                  ref
                                                      .read(
                                                          disciplineControllerProvider
                                                              .notifier)
                                                      .share(discipline,
                                                          description);

                                                  Navigator.pop(context);
                                                },
                                              ));
                                    },
                                    icon: Icon(Icons.share))
                              ]),
                            )
                        ],
                      )),
              ),
          error: (error, _) => Text(error.toString()),
          loading: () => Center(child: CircularProgressIndicator())),
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
