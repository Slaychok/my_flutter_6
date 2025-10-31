import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Еда', 'icon': Icons.restaurant, 'color': Colors.red, 'description': 'Продукты питания, рестораны, кафе'},
    {'name': 'Транспорт', 'icon': Icons.directions_car, 'color': Colors.blue, 'description': 'Бензин, такси, общественный транспорт'},
    {'name': 'Развлечения', 'icon': Icons.movie, 'color': Colors.orange, 'description': 'Кино, концерты, хобби'},
    {'name': 'Здоровье', 'icon': Icons.local_hospital, 'color': Colors.green, 'description': 'Лекарства, врачи, спорт'},
    {'name': 'Одежда', 'icon': Icons.shopping_bag, 'color': Colors.purple, 'description': 'Одежда, обувь, аксессуары'},
    {'name': 'Дом', 'icon': Icons.home, 'color': Colors.brown, 'description': 'Коммунальные услуги, ремонт, мебель'},
    {'name': 'Прочее', 'icon': Icons.more_horiz, 'color': Colors.grey, 'description': 'Прочие расходы'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории расходов'),
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
              subtitle: Text(category['description'] as String),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _showCategoryDetails(context, category);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  void _showCategoryDetails(BuildContext context, Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Категория: ${category['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(category['icon'] as IconData, color: category['color'] as Color),
                const SizedBox(width: 10),
                Text(
                  category['name'] as String,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(category['description'] as String),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}