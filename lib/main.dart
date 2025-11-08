import 'package:flutter/material.dart';
import 'package:my_flutter_6/config/router.dart';
import 'di/locator.dart';
import 'features/state/app_state.dart';
import 'features/widgets/app_state_provider.dart';
import 'features/services/settings_service.dart';

void main() {
  setupLocator(); // Инициализируем GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsService = getIt<SettingsService>(); // GetIt для сервиса настроек
    final appState = getIt<AppState>(); // GetIt для состояния приложения

    return AppStateProvider( // InheritedWidget для состояния приложения
      appState: appState,
      child: MaterialApp.router(
        theme: settingsService.isDarkMode ? ThemeData.dark() : ThemeData.light(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}