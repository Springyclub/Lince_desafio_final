import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Class vacancy
class Vacancy {
  /// Vacancy id
  final int? id;

  /// Vacancy photo
  final String? photo;

  /// Vacancy parked
  final int parked;

  /// Vacancy name driver
  final String nameDriver;

  /// Vacancy name card board
  final String cardBoard;

  /// Vacancy parking lane
  final String parkingLane;

  /// Vacancy date time
  final String dateTime;

  /// Vacancy exitData
  final String? exitData;


  ///
  final double? valor;
  /// Constructor vacancy
  Vacancy(
      {this.id,
      required this.nameDriver,
      required this.cardBoard,
      required this.parkingLane,
      required this.dateTime,
      this.photo,
      required this.parked,
      this.exitData,
      this.valor});

  /// From map
  factory Vacancy.fromMap(Map<String, dynamic> json) => Vacancy(
      id: json['id'],
      nameDriver: json['nameDriver'],
      cardBoard: json['cardBoard'],
      parkingLane: json['parkingLane'],
      dateTime: json['dateTime'],
      photo: json['photo'],
      parked: json['parked'],
      exitData: json['exitData'],
      valor:json['valor']);

  /// To map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameDriver': nameDriver,
      'cardBoard': cardBoard,
      'parkingLane': parkingLane,
      'dateTime': dateTime,
      'photo': photo,
      'parked': parked,
      'exitData': exitData,
      'valor' : valor
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
    var path = join(documentsDirectory.path, 'vv.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE vv(
          id INTEGER PRIMARY KEY,
          nameDriver TEXT,
          cardBoard TEXT,
          parkingLane TEXT,
          dateTime TEXT,
          photo TEXT,
          parked INTEGER,
          exitData TEXT,
          valor REAL
      )
      ''');
  }

  /// Get vacancy
  Future<List<Vacancy>> getVacancies() async {
    var db = await instance.database;
    var groceries = await db.query('vv', orderBy: 'id');
    final groceryList = groceries.isNotEmpty
        ? groceries.map(Vacancy.fromMap).toList()
        : <Vacancy>[];
    return groceryList;
  }

  /// Add vacancy
  Future<int> add(Vacancy grocery) async {
    final db = await instance.database;
    return db.insert('vv', grocery.toMap());
  }

  /// Remove vacancy
  Future<int> remove(int id) async {
    final db = await instance.database;
    return db.delete('vv', where: 'id = ?', whereArgs: [id]);
  }


  /// Exite date
  Future<int> removeList(int id, String exitDate, double valor) async {
    final db = await instance.database;
    return db.update('vv', {'valor': valor,'parked':0},
        where: 'id = ?', whereArgs: [id]);
  }

  /// Remove vacancy
  Future<void> removeAll(List<Vacancy> list) async {
    final db = await instance.database;
    await db.delete('vv');
  }
}
