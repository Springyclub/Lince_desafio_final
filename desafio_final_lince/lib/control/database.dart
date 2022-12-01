import 'package:sqflite/sqflite.dart';

const _dbVersion = 2;

class Person {
  Person.fromDatabaseRow(Map<String, Object?> row)
      : cardBoard = row['cardBoard'] as String,
        nameDriver = row['nameDriver'] as String,
        id = row['id'] as int;

  int? id;
  final String cardBoard;
  final String nameDriver;

  /// Constructor person
  Person({required this.id, required this.cardBoard, required this.nameDriver});
}

/// Data base helper
class DatabaseHelper {
  DatabaseHelper() {
    init();
  }

  late Database _db;

  void init() async {
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/table.db';

    const sqlperson = '''CREATE TABLE Driver(
    id INTEGER,
    nameDriver TEXT NOT NULL,
    cardBoard TEXT NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
  )''';

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database database, int version) async {
        await database.execute(sqlperson);
        //
      },
    );
  }

  Future<Person?> getPersonNamed(String name) async {
    final rows = await _db.query(
      'Driver',
      columns: ['nameDriver', 'age'],
      where: 'nameDriver = ?',
      whereArgs: [
        name,
      ],
    );

    if (rows.isNotEmpty) {
      return Person.fromDatabaseRow(rows.first);
    }

    return null;
  }

  Future<void> insertPerson(Person person) async {
    print('Person > ${person.nameDriver}, ${person.cardBoard}, ');
    await _db.insert(
      'Driver',
      {
        'nameDriver': person.nameDriver,
        'cardBoard': person.nameDriver,
        'id': person.id
      },
    );
  }

  Future<void> deletePerson(Person person) async {
    print('Delete person > ${person.nameDriver},');
    await _db.delete(
      'Driver',
      where: 'name = ?',
      whereArgs: [
        person.nameDriver,
      ],
    );
  }

  Future<List<Person>> getAll() async {
    final rows = await _db.query(
      'Driver', orderBy: 'id');
    print(rows);
    final list = <Person>[];
    for (final row in rows) {
      list.add(Person.fromDatabaseRow(row));
    }
    return list;
  }
}
