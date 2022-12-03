import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Class vacancy
class Vacancy {
  /// Vacancy id
  final int? id;

  /// Vacancy photo
  final String? photo;

  /// Vacancy name driver
  final String nameDriver;

  /// Vacancy name card board
  final String cardBoard;

  /// Vacancy parking lane
  final String parkingLane;

  /// Vacancy date time
  final String dateTime;

  /// Constructor vacancy
  Vacancy(
      {this.id,
      required this.nameDriver,
      required this.cardBoard,
      required this.parkingLane,
      required this.dateTime,
      this.photo});

  /// From map
  factory Vacancy.fromMap(Map<String, dynamic> json) => Vacancy(
      id: json['id'],
      nameDriver: json['nameDriver'],
      cardBoard: json['cardBoard'],
      parkingLane: json['parkingLane'],
      dateTime: json['dateTime'],
      photo: json['photo']);

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameDriver': nameDriver,
      'cardBoard': cardBoard,
      'parkingLane': parkingLane,
      'dateTime': dateTime,
      'photo': photo
    };
  }
}

/// Data base helper
class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  /// Instace data base
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  /// get database
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, 'vacan.db');
    return openDatabase(
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
          dateTime TEXT,
          photo TEXT
      )
      ''');
  }

  /// Get vacancy
  Future<List<Vacancy>> getVacancies() async {
    var db = await instance.database;
    var groceries = await db.query('ggg', orderBy: 'id');
    final groceryList = groceries.isNotEmpty
        ? groceries.map(Vacancy.fromMap).toList()
        : <Vacancy>[];
    return groceryList;
  }

  /// Add vacancy
  Future<int> add(Vacancy grocery) async {
    final db = await instance.database;
    return db.insert('ggg', grocery.toMap());
  }

  /// Remove vacancy
  Future<int> remove(int id) async {
    final db = await instance.database;
    return db.delete('ggg', where: 'id = ?', whereArgs: [id]);
  }

  /// Update vacancy
  Future<int> update(Vacancy grocery) async {
    var db = await instance.database;
    return db.update('ggg', grocery.toMap(),
        where: 'id = ?', whereArgs: [grocery.id]);
  }
  /// Remove vacancy
  Future<void> removeAll(List<Vacancy> list) async {
    final db = await instance.database;
    await db.delete('ggg');
  }

}
