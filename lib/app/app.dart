import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../features/state/expenses_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Учет расходов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExpensesContainer(), // Запускаем наше приложение с контейнера
    );
  }
}