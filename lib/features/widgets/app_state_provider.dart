// features/widgets/app_state_provider.dart
import 'package:flutter/material.dart';
import '../state/app_state.dart';

class AppStateProvider extends InheritedWidget {
  final AppState appState;

  const AppStateProvider({
    Key? key,
    required this.appState,
    required Widget child,
  }) : super(key: key, child: child);

  static AppStateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(result != null, 'No AppStateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) {
    return appState != oldWidget.appState;
  }
}