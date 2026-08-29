import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'gbians_local.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            farmer TEXT
          )
        ''');
      },
    );
  }


  static Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    return await db.insert('products', product);
  }


  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }


  static Future<int> updateProduct(int id, Map<String, dynamic> product) async {
    final db = await database;
    return await db.update('products', product, where: 'id = ?', whereArgs: [id]);
  }


  static Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}




class SqfliteLocalDBScreen extends StatefulWidget {
  const SqfliteLocalDBScreen({super.key});
  @override
  State<SqfliteLocalDBScreen> createState() => _SqfliteLocalDBScreenState();
}

class _SqfliteLocalDBScreenState extends State<SqfliteLocalDBScreen> {
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final data = await DBHelper.getProducts();
    setState(() => _products = data);
  }

  Future<void> _addProduct() async {
    await DBHelper.insertProduct({
      'name': 'Organic Honey',
      'price': 800.0,
      'farmer': 'Ali (Hunza)',
    });
    _loadProducts();
  }

  Future<void> _deleteProduct(int id) async {
    await DBHelper.deleteProduct(id);
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local DB (sqflite)')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final p = _products[index];
          return ListTile(
            title: Text(p['name']),
            subtitle: Text('Rs. ${p['price']} — ${p['farmer']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteProduct(p['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}