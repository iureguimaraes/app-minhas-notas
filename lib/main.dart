import 'package:app_minhas_notas/disciplines/pages/disciplines_list.dart';
import 'package:app_minhas_notas/recomendations/pages/recomendations_list.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  runApp(ProviderScope(child: MinhasNotasApp()));
}

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) => setState(() {
          _currentPageIndex = index;
        }),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Minhas Notas',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box),
            label: 'Disciplinas Compartilhadas',
          ),
        ],
      ),
      body: [DisciplinesList(), RecomendationsList()]
          .elementAt(_currentPageIndex),
    );
  }
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
      home: AppNavigationBar(),
    );
  }
}
