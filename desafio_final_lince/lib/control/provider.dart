import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller.dart';
import 'database.dart';
import 'utils/constants.dart';

///...
class MyScreenState extends ChangeNotifier {
  final _helper = DatabaseHelper();

  /// Init method
  MyScreenState() {
    unawaited(_init());
  }
  List<String> _list = [];

  int _vacanciesNumber = 0;
  bool _loading = true;

  final _controller = TextEditingController();

  /// Vacancies number
  int get vacanciesNumber => _vacanciesNumber;

  List<String> get list => _list;


  final _formKey = GlobalKey<FormState>();

  ///Form key
  GlobalKey<FormState> get formKey => _formKey;

  /// Text Controller
  TextEditingController get controller => _controller;

  /// Circular progress indicator
  bool get loading => _loading;

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _vacanciesNumber = prefs.getInt(keyNumberVacancies) ?? 0;

    Future.delayed(const Duration(seconds: 3), () {
      _loading = false;
      notifyListeners();
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

  void getPerson() async {
    final all = await _helper.getAll();
    for (final person in all) {
      _list.add(person.name);
      print('Name: ${person.name}, Age: ${person.age}');
    }
    print(_list);


  }
}
