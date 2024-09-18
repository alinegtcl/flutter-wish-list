import 'package:flutter/material.dart';
import 'package:wish_list/utils.dart';
import 'package:wish_list/wish.dart';

import 'database_helper.dart';

class DetailScreen extends StatelessWidget {
  final Wish wish;

  const DetailScreen({super.key, required this.wish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Desejo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Título: ${wish.title}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Data: ${wish.date}',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Importância: ${wish.importance}',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 36, color: Colors.red),
                  onPressed: () {
                    DatabaseHelper.instance.deleteWish(wish.id!);
                    showToast("Desejo excluído com sucesso!");
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
