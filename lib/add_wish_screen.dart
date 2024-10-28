import 'package:flutter/material.dart';
import 'package:wish_list/firestore_service.dart';
import 'package:wish_list/utils.dart';

class AddWishScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _importanceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddWishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Desejo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O título é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Data'),
              ),
              TextFormField(
                controller: _importanceController,
                decoration: const InputDecoration(labelText: 'Prioridade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A prioridade é obrigatória';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirestoreService().addWish(_titleController.text,
                        _dateController.text, _importanceController.text);
                    showToast("Desejo adicionado com sucesso!");
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
