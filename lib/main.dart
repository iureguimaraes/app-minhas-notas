import 'package:app_minhas_notas/disciplines/pages/disciplines_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MinhasNotasApp()));
}

class MinhasNotasApp extends StatelessWidget {
  const MinhasNotasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Minhas Notas',
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF154479),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: Color(0xFF154479),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
          )),
          inputDecorationTheme:
              InputDecorationTheme(border: OutlineInputBorder()),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF154479),
            foregroundColor: Colors.white,
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF154479),
              foregroundColor: Colors.white)),
      home: DisciplinesList(),
    );
  }
}
