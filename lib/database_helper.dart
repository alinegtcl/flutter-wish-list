import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wish_list/wish.dart';

class DatabaseHelper {
  static const _databaseName = "wishlist.db";
  static const _databaseVersion = 1;
  static const table = 'wishlist_table';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        importance TEXT NOT NULL
      )
      ''');
  }

  Future<int> insertWish(Wish wish) async {
    Database? db = await instance.database;
    return await db!.insert(table, wish.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllWishes() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int> deleteWish(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
