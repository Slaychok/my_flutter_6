import 'package:get_it/get_it.dart';
import 'package:my_flutter_6/features/services/settings_service.dart';
import 'package:my_flutter_6/features/state/app_state.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AppState>(() => AppState());

  getIt.registerLazySingleton<SettingsService>(() => SettingsService());
}