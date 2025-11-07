// features/screens/expenses_list_screen.dart
import 'package:flutter/material.dart';
import 'package:my_flutter_6/features/widgets/app_inherited_widget.dart';
import 'package:my_flutter_6/features/widgets/expenses_list_view.dart';
import 'package:my_flutter_6/features/screens/images_screen.dart';
import 'package:my_flutter_6/features/screens/statistics_screen.dart';
import 'package:my_flutter_6/features/screens/categories_screen.dart';
import 'package:go_router/go_router.dart';

class ExpensesListScreen extends StatelessWidget {
  final VoidCallback onAdd;

  const ExpensesListScreen({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  // === СТРАНИЧНАЯ НАВИГАЦИЯ (Navigator) ===
  void _openImagesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const ImagesScreen()),
    );
  }

  void _openStatisticsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const StatisticsScreen()),
    );
  }

  void _openCategoriesScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const CategoriesScreen()),
    );
  }

  // === МАРШРУТИЗИРОВАННАЯ НАВИГАЦИЯ (GoRouter) ===
  void _openImagesScreenGoRouter(BuildContext context) {
    context.push('/images');
  }

  void _openStatisticsScreenGoRouter(BuildContext context) {
    context.push('/statistics');
  }

  void _openCategoriesScreenGoRouter(BuildContext context) {
    context.go('/categories');
  }

  Widget _buildNavigationSection(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Демонстрация навигации:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const Text(
              '📱 СТРАНИЧНАЯ НАВИГАЦИЯ (Navigator):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _openImagesScreen(context),
                  child: const Text('Галерея (push)'),
                ),
                ElevatedButton(
                  onPressed: () => _openStatisticsScreen(context),
                  child: const Text('Статистика (push)'),
                ),
                ElevatedButton(
                  onPressed: () => _openCategoriesScreen(context),
                  child: const Text('Категории (pushReplacement)'),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              '🛣️ МАРШРУТИЗИРОВАННАЯ НАВИГАЦИЯ (GoRouter):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _openImagesScreenGoRouter(context),
                  child: const Text('Галерея (push)'),
                ),
                ElevatedButton(
                  onPressed: () => _openStatisticsScreenGoRouter(context),
                  child: const Text('Статистика (push)'),
                ),
                ElevatedButton(
                  onPressed: () => _openCategoriesScreenGoRouter(context),
                  child: const Text('Категории (go)'),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              '💡 Примечание:\n'
                  '• push - вертикальная навигация'
                  ' (сохраняет историю)\n'
                  '• pushReplacement/go - горизонтальная навигация (заменяет экран)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Способ 1: InheritedWidget для получения состояния
    final appState = AppInheritedWidget.of(context).appState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои Расходы'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.navigation),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'images',
                child: Text('📱 Галерея (Navigator)'),
              ),
              const PopupMenuItem(
                value: 'stats',
                child: Text('📱 Статистика (Navigator)'),
              ),
              const PopupMenuItem(
                value: 'categories',
                child: Text('📱 Категории (Navigator)'),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'images':
                  _openImagesScreen(context);
                  break;
                case 'stats':
                  _openStatisticsScreen(context);
                  break;
                case 'categories':
                  _openCategoriesScreen(context);
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildNavigationSection(context),
          const SizedBox(height: 10),
          Expanded(
            child: ExpensesListView(
              expenses: appState.expenses,
              onDelete: appState.deleteExpense,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'images_btn',
            onPressed: () => _openImagesScreen(context),
            child: const Icon(Icons.photo),
            mini: true,
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add_btn',
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}