import 'package:flutter/material.dart';
import 'package:wish_list/wish.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Desejos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WishListScreen(),
    );
  }
}

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<Wish> wishList = [
    Wish(title: "terminar minha pos",
        date: "junho/2025",
        importance: "alta"),
    Wish(title: "terminar trabalho de dm3",
        date: "setembro/2024",
        importance: "critica")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Desejos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar para adição
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
