// features/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:my_flutter_6/di/locator.dart';
import 'package:my_flutter_6/features/services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = getIt<SettingsService>();
  final TextEditingController _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _budgetController.text = _settingsService.monthlyBudget.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Переключение темы через GetIt
            Card(
              child: ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Тема оформления'),
                subtitle: Text(_settingsService.isDarkMode ? 'Темная' : 'Светлая'),
                trailing: Switch(
                  value: _settingsService.isDarkMode,
                  onChanged: (value) {
                    _settingsService.toggleTheme();
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Настройка бюджета через GetIt
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Месячный бюджет',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _budgetController,
                      decoration: const InputDecoration(
                        labelText: 'Бюджет в рублях',
                        prefixText: '₽ ',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final budget = double.tryParse(_budgetController.text) ?? 0.0;
                        if (budget > 0) {
                          _settingsService.updateMonthlyBudget(budget);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Бюджет обновлен')),
                          );
                        }
                      },
                      child: const Text('Сохранить бюджет'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}