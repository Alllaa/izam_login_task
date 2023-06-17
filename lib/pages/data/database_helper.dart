import 'package:flutter/material.dart';
import 'package:izam_task/consts/storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
class DatabaseHelper {


  // Make the class singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

   Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final pathToDatabase = path.join(databasePath, StorageKeys.databaseName);
    return await openDatabase(
      pathToDatabase,
      version: StorageKeys.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${StorageKeys.table} (
        ${StorageKeys.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${StorageKeys.columnEmail} TEXT NOT NULL,
        ${StorageKeys.columnPassword} TEXT NOT NULL,
        ${StorageKeys.columnLoginCount} INTEGER DEFAULT 1
      )
    ''');
  }

  Future<int> insertLoginRecord(String email, String password) async {
    final db = await database;
    return await db.insert(
      StorageKeys.table,
      {
        StorageKeys.columnEmail: email,
        StorageKeys.columnPassword: password,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getLoginRecords() async {
    final db = await database;
    return await db.query(StorageKeys.table);
  }

  Future<Object?> getLoginCount(String email, String password) async {
    final db = await database;
    final result = await db.query(
      StorageKeys.table,
      where: '${StorageKeys.columnEmail} = ? AND ${StorageKeys.columnPassword} = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? result.first[StorageKeys.columnLoginCount] : 1;
  }

  Future<void> updateLoginCount(String email, String password) async {
    final db = await database;
    final loginCount = await getLoginCount(email, password);


    await db.update(
      StorageKeys.table,
      {StorageKeys.columnLoginCount: int.tryParse(loginCount.toString())! + 1},
      where: '${StorageKeys.columnEmail} = ? AND ${StorageKeys.columnPassword} = ?',
      whereArgs: [email, password],
    );
  }
}
