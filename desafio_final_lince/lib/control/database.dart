import 'package:sqflite/sqflite.dart';

const _dbVersion = 1;

/// Person db
class Person {
  /// Construcor person db

  Person(this.name, this.age);

  Person.fromDatabaseRow(Map<String, Object?> row)
      : name = row['name'] as String,
        age = row['age'] as int;

  final int age;
  final String name;
}

/// Data base helper
class DatabaseHelper {
  /// Data base helper with inti
  DatabaseHelper() {
    init();
  }

  late Database _db;


  void init() async {
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/demo.db';

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (database, version) async {
        await database.execute('''
        CREATE TABLE person (
          name TEXT,
          age  INT
        );
        ''');
        //
      },
    );
  }

  Future<Person?> getPersonNamed(String name) async {
    final rows = await _db.query(
      'person',
      columns: ['name', 'age'],
      where: 'name = ?',
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
    print('Person > ${person.name}, ${person.age}');

    await _db.insert(
      'person',
      {
        'name': person.name,
        'age': person.age,
      },
    );
  }

  Future<void> deletePerson(Person person) async {
    print('Delete person > ${person.name}, ${person.age}');
    await _db.delete(
      'person',
      where: 'name = ?',
      whereArgs: [
        person.name,
      ],
    );
  }

  Future<List<Person>> getAll() async {
    final rows = await _db.query(
      'person',
      columns: ['name', 'age'],
    );

    final list = <Person>[];
    for (final row in rows) {
      list.add(Person.fromDatabaseRow(row));
    }

    return list;
  }
}
