import 'package:app_minhas_notas/disciplines/controllers/discipline_controller.dart';
import 'package:app_minhas_notas/recomendations/controllers/recomendations_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecomendationsList extends ConsumerWidget {
  const RecomendationsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recomendations = ref.watch(recomendationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Disciplinas Compartilhadas')),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(recomendationControllerProvider.notifier).refresh();
        },
        child: recomendations.when(
            data: (recomendations) => recomendations.isEmpty
                ? Center(child: Text('Nenhuma recomendação encontrada'))
                : ListView(
                    children: [
                      for (var recomendation in recomendations)
                        ListTile(
                          title: Text(recomendation.discipline.name),
                          subtitle: Text(recomendation.description),
                          trailing: Wrap(spacing: 4, children: [
                            IconButton(
                              icon: Icon(Icons.save_alt),
                              onPressed: () {
                                ref
                                    .read(disciplineControllerProvider.notifier)
                                    .addDiscipline(recomendation.discipline.clone());
                              },
                            ),
                          ]),
                        )
                    ],
                  ),
            error: (error, trace) => Text(error.toString()),
            loading: () => Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
