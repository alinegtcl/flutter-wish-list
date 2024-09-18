import 'package:flutter/material.dart';
import 'package:wish_list/wish.dart';

import 'add_wish_screen.dart';
import 'database_helper.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddWishScreen()),
              ).then((_) {
                 _loadWishes();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: wishList.length,
        itemBuilder: (context, index) {
          final wish = wishList[index];
          return ListTile(
            title: Text(wish.title),
            subtitle: Text('${wish.date} - Importância: ${wish.importance}'),
            onTap: () {
              // Navegar para detalhes ou exclusão
            },
          );
        },
      ),
    );
  }
}
