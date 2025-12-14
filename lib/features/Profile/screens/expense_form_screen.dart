import 'package:flutter/material.dart';

class ExpenseFormScreen extends StatefulWidget {
  final Function({
  required String title,
  required double amount,
  required DateTime date,
  required String category,
  String? description,
  })
  onSave;
  final VoidCallback onCancel;

  const ExpenseFormScreen({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Еда'; // Категория по умолчанию
  final _descriptionController = TextEditingController();

  // Список категорий
  final List<String> _categories = [
    'Еда',
    'Транспорт',
    'Развлечения',
    'Здоровье',
    'Одежда',
    'Дом',
    'Прочее',
  ];

  void _submit() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (title.isEmpty || amount <= 0) {
      // Простая валидация
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Неверный ввод'),
          content: const Text(
            'Пожалуйста, введите название и корректную сумму.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Ок'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onSave(
      title: title,
      amount: amount,
      date: _selectedDate,
      category: _selectedCategory,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
    );
  }

  // Функция для выбора даты
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: firstDate,
      lastDate: now,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить расход')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Сумма',
                prefixText: '₽ ',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            // Выбор даты
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Дата: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text('Выбрать дату'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Выбор категории
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories
                  .map(
                    (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
              decoration: const InputDecoration(labelText: 'Категория'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Описание (необязательно)',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text('Назад'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Добавить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
