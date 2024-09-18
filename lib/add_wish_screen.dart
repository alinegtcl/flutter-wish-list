import 'package:flutter/material.dart';
import 'package:wish_list/wish.dart';
import 'database_helper.dart';

class AddWishScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _importanceController = TextEditingController();

  AddWishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Desejo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: _importanceController,
              decoration: const InputDecoration(labelText: 'Importância'),
            ),
            ElevatedButton(
              onPressed: () {
                final wish = Wish(
                  title: _titleController.text,
                  date: _dateController.text,
                  importance: _importanceController.text,
                );
                DatabaseHelper.instance.insertWish(wish);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
