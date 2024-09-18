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
          ? const Center(
              child: Text(
                'Você não tem desejos cadastrados.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: wishList.length,
              itemBuilder: (context, index) {
                final wish = wishList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      wish.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        'Até ${wish.date} - Prioridade: ${wish.importance}'),
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
