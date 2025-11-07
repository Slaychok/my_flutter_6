import 'package:get_it/get_it.dart';
import '../features/state/app_state.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Регистрируем AppState как синглтон
  getIt.registerLazySingleton<AppState>(() => AppState());

  // Можно также зарегистрировать другие сервисы
  // getIt.registerLazySingleton<ExpenseService>(() => ExpenseService());
  // getIt.registerFactory<ExpenseFormBloc>(() => ExpenseFormBloc());
}