import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:my_flutter_6/config/router.dart';
import 'package:my_flutter_6/di/locator.dart';
import 'package:my_flutter_6/features/bloc/expenses/expenses_bloc.dart';
import 'package:my_flutter_6/features/bloc/observer/app_bloc_observer.dart';
import 'package:my_flutter_6/features/services/settings_service.dart';

void main() {
  setupLocator();
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsService = getIt<SettingsService>();

    return BlocProvider(
      create: (context) => ExpensesBloc()..add(LoadExpenses()),
      child: MaterialApp.router(
        theme: settingsService.isDarkMode ? ThemeData.dark() : ThemeData.light(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}