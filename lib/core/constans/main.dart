import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_6/config/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Учет расходов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}