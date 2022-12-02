import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/constants.dart';
import 'package:desafio_final_lince/control/database.dart';

///...
class MyScreenState extends ChangeNotifier {
  DatabaseHelper db = DatabaseHelper.instance;
  List<Grocery> _list = [];

  List<Grocery> get list => _list;

  /// Init method
  MyScreenState() {
    unawaited(_init());
  }

  int _vacanciesNumber = 0;
  bool _loading = true;

  final _controller = TextEditingController();

  /// Vacancies number
  int get vacanciesNumber => _vacanciesNumber;

  final _formKey = GlobalKey<FormState>();

  ///Form key
  GlobalKey<FormState> get formKey => _formKey;

  /// Text Controller
  TextEditingController get controller => _controller;

  /// Circular progress indicator
  bool get loading => _loading;

  Future<void> _init() async {
    await getDb();
    final prefs = await SharedPreferences.getInstance();
    _vacanciesNumber = prefs.getInt(keyNumberVacancies) ?? 0;

    Future.delayed(const Duration(seconds: 3), () {
      _loading = false;
    });
  }

  /// Delete number vacancies
  Future<void> deleteNumberVacancies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyNumberVacancies);
    notifyListeners();
  }

  /// Number vacancies
  Future<void> numberVacancies() async {
    final text = controller.text;
    final numeroVagas = int.tryParse(text) ?? 0;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyNumberVacancies, numeroVagas);
    _vacanciesNumber = numeroVagas;
  }

  /// Get data base
  Future<void> getDb() async {
    var dba = await db.getGroceries();
    _list.clear();
    for (final pp in dba) {
      _list.add(pp);
    }
    notifyListeners();
  }

  /// Add vacancy
  void addVacancy(Grocery vacancy) async {
    print('asdasdasdasdasdadasdasd');
    print(vacancy);
    if(vacancy != null){
      await db.add(vacancy);
      await getDb();
    }
    notifyListeners();

  }

  /// Remove vacancy
  void removeVacancy(int idVacancy) async {
    if (idVacancy == null) {
    } else {
      await db.remove(idVacancy);
      await getDb();
    }
    notifyListeners();
  }
}
