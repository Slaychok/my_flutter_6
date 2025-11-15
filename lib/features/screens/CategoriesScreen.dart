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
      body: Column(
        children: [
          // Заголовок категории
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.red[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.restaurant, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Еда',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Продукты питания, рестораны, кафе',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Общая сумма
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Colors.red[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Общие расходы:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '1500 ₽',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Заголовок списка расходов
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'История расходов:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Список расходов
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildExpenseItem(
                  title: 'Продукты из супермаркета',
                  amount: 800,
                  date: '15 января 2024',
                  icon: Icons.shopping_cart,
                ),
                _buildExpenseItem(
                  title: 'Обед в кафе',
                  amount: 400,
                  date: '16 января 2024',
                  icon: Icons.restaurant_menu,
                ),
                _buildExpenseItem(
                  title: 'Кофе и выпечка',
                  amount: 300,
                  date: '17 января 2024',
                  icon: Icons.coffee,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildExpenseItem({
    required String title,
    required int amount,
    required String date,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          '$amount ₽',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}