import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Class vacancy
class Grocery {
  final int? id;
  final String nameDriver;
  final String cardBoard;
  final String parkingLane;
  final String dateTime;


  /// Constructor vacancy
  Grocery(
      {this.id,
      required this.nameDriver,
      required this.cardBoard,
      required this.parkingLane,
      required this.dateTime
      });

  /// From map
  factory Grocery.fromMap(Map<String, dynamic> json) => Grocery(
      id: json['id'],
      nameDriver: json['nameDriver'],
      cardBoard: json['cardBoard'],
      parkingLane: json['parkingLane'],
      dateTime: json['dateTime']
  );

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameDriver': nameDriver,
      'cardBoard': cardBoard,
      'parkingLane': parkingLane,
      'dateTime' : dateTime
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ggg.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ggg(
          id INTEGER PRIMARY KEY,
          nameDriver TEXT,
          cardBoard TEXT,
          parkingLane TEXT,
          dateTime TEXT
      )
      ''');
  }

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('ggg', orderBy: 'id');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => Grocery.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert('ggg', grocery.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('ggg', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Grocery grocery) async {
    Database db = await instance.database;
    return await db.update('ggg', grocery.toMap(),
        where: "id = ?", whereArgs: [grocery.id]);
  }
}
