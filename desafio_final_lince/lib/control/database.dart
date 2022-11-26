import 'dart:async';
import 'dart:io';

import 'package:desafio_final_lince/control/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class Vacancy{
  final int? id;
  final String? name;
  final String? cardBoard;

  Vacancy({this.id, required this.name, required this.cardBoard});

  factory Vacancy.fromMap(Map<String, dynamic> json)=>
  Vacancy(
  id: json['id'],
  name : json['name'],
  cardBoard : json['cardBoard']
  );

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'cardBoard': cardBoard,
    };
  }
}

class DataBaseHelper{
  DataBaseHelper._privateContructor();
  static final DataBaseHelper instance = DataBaseHelper._privateContructor();
  static Database? _database;
  Future<Database> get database async => _database??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'vacancy.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

  }
}
Future _onCreate(Database db,int version)async{
  await db.execute('''
  CREATE TABLE vacancy(
  id INTEGER PRIMARY KEY,
  name TEXT,
  cardBoard TEXT
  )
  ''');
}
Future<List<Vacancy>> getVacancy() async {
  Database db = await DataBaseHelper.instance.database;
  var groceries = await db.query('vacancy', orderBy: 'name');
  List<Vacancy> groceryList = groceries.isNotEmpty
      ? groceries.map((c) => Vacancy.fromMap(c)).toList()
      : [];
  return groceryList;
}
Future<int> add(Vacancy vacancy) async{
   Database db = await DataBaseHelper.instance.database;
   print(db);
  return await db.insert('vacancy', vacancy.toMap());
}

Future<int> remove(int id)async{
  Database db = await DataBaseHelper.instance.database;
  return await db.delete('vacancy',where: 'id = ?', whereArgs: [id]);
}

