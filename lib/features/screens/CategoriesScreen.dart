import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Еда', 'icon': Icons.restaurant, 'color': Colors.red},
    {'name': 'Транспорт', 'icon': Icons.directions_car, 'color': Colors.blue},
    {'name': 'Развлечения', 'icon': Icons.movie, 'color': Colors.orange},
    {'name': 'Здоровье', 'icon': Icons.local_hospital, 'color': Colors.green},
    {'name': 'Одежда', 'icon': Icons.shopping_bag, 'color': Colors.purple},
    {'name': 'Дом', 'icon': Icons.home, 'color': Colors.brown},
    {'name': 'Прочее', 'icon': Icons.more_horiz, 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории расходов'),
        // Нет кнопки назад - это горизонтальная навигация
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: category['color'] as Color,
                child: Icon(
                  category['icon'] as IconData,
                  color: Colors.white,
                ),
              ),
              title: Text(category['name'] as String),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Демонстрация вертикальной навигации из горизонтальной
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CategoryDetailScreen(category: category),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const Scaffold(),
            ),
          );
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> category;

  const CategoryDetailScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категория: ${category['name']}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // Вертикальный возврат
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category['icon'] as IconData,
              size: 64,
              color: category['color'] as Color,
            ),
            const SizedBox(height: 20),
            Text(
              category['name'] as String,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Детальная информация о категории\n${category['name']}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}