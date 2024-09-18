import 'package:flutter/material.dart';
import 'package:wish_list/wish.dart';

import 'add_wish_screen.dart';
import 'database_helper.dart';
import 'detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Desejos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WishListScreen(),
    );
  }
}

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<Wish> wishList = [];

  @override
  void initState() {
    super.initState();
    _loadWishes();
  }

  void _loadWishes() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>> wishes = await helper.getAllWishes();
    setState(() {
      wishList = wishes.map((e) => Wish.fromMap(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Desejos'),
      ),
      body: wishList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Você não tem desejos cadastrados.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20), // Espaço entre o texto e a imagem
                  Icon(
                    Icons.hourglass_empty,
                    size: 64,
                    color: Colors.grey[400], // Cor do ícone
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Não perca tempo, adicione um desejo!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: wishList.length,
              itemBuilder: (context, index) {
                final wish = wishList[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      wish.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Até ${wish.date} - Prioridade: ${wish.importance}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(wish: wish)),
                      ).then((value) {
                        if (value == true) {
                          _loadWishes();
                        }
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddWishScreen()),
          ).then((_) {
            _loadWishes();
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
