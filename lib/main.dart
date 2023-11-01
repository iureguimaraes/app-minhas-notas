import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Minhas Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddDisciplinePage(title: 'App Minhas Notas'),
    );
  }
}

class AddDisciplinePage extends StatelessWidget {
  final String title;

  const AddDisciplinePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
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
              builder: (context) =>
                  AddActivityPage(title: 'Adicionar disciplina'),
            ),
          );
        },
        tooltip: 'Adicionar disciplina',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddActivityPage extends StatelessWidget {
  final String title;

  const AddActivityPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: Text(
                      'Essa será a tela de adicionar uma nova atividade à disciplina',
                      textAlign: TextAlign.center,
                    )))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CalculateFinalGradePage(title: 'Calcula a nota final'),
            ),
          );
        },
        tooltip: 'Calcular nota final',
        child: const Icon(Icons.calculate),
      ),
    );
  }
}

class CalculateFinalGradePage extends StatelessWidget {
  final String title;

  const CalculateFinalGradePage({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Calcula nota final',
            ),
          ],
        ),
      ),
    );
  }
}
