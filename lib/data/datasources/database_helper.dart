import 'dart:async';
import 'tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createUsersTable);
        await db.execute(createPlayersTable);
        await db.execute(createLevelsTable);
        await db.execute(createUserProgressTable);
        await db.execute(createItemsTable);
        await db.execute(createUserItemsTable);
      },
    );
  }
}
