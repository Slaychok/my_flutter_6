// features/widgets/app_inherited_widget.dart
import 'package:flutter/material.dart';
import '../state/app_state.dart';

class AppInheritedWidget extends InheritedWidget {
  final AppState appState;

  const AppInheritedWidget({
    Key? key,
    required this.appState,
    required Widget child,
  }) : super(key: key, child: child);

  static AppInheritedWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppInheritedWidget>();
    assert(result != null, 'No AppInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppInheritedWidget oldWidget) {
    return appState != oldWidget.appState;
  }
}