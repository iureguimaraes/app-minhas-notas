import 'package:app_minhas_notas/disciplines/models/discipline.dart';
import 'package:flutter/material.dart';

class ShareDisciplineForm extends StatelessWidget {
  final _descriptionController = TextEditingController();
  final ValueSetter<String> onSubmit;
  final Discipline discipline;

  ShareDisciplineForm(
      {super.key, required this.discipline, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(runSpacing: 16, children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Descrição',
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText:
                'Escreva uma descrição curta que ajude a identificar a disciplina.',
          ),
          controller: _descriptionController,
          minLines: 4,
          maxLines: 4,
        ),
        ElevatedButton.icon(
          onPressed: () {
            onSubmit(_descriptionController.text);
          },
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(Size(double.infinity, 50))),
          label: Text('Compartilhar'),
          icon: Icon(Icons.share),
        )
      ]),
    );
  }
}
