import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'database.dart';
import 'utils/constants.dart';

///...
class MyScreenState extends ChangeNotifier {
  /// Init method
  MyScreenState() {
    unawaited(_init());
  }

  final ImagePicker _picker = ImagePicker();

  /// Data base helper
  DatabaseHelper db = DatabaseHelper.instance;

  /// List vacancy to homPage
  final List<Vacancy> _list = [];

  /// Get list vacancy
  List<Vacancy> get list => _list;

  bool get hasVacancy => _vacanciesNumber != 0;

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
    print('Aqui 0 -> $_vacanciesNumber');
    _vacanciesNumber = prefs.getInt(keyNumberVacancies) ?? 0;
    print('AQUI 1 -> $_vacanciesNumber');
    print('AQUI 2 -> ${prefs.getInt(keyNumberVacancies) ?? 0}');
    _loading = false;
    notifyListeners();
  }

  Future<void> reloadInfo() async {
    notifyListeners();
  }

  /// Delete number vacancies
  Future<void> deleteNumberVacancies() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove(keyNumberVacancies);
    notifyListeners();
  }

  /// Number vacancies
  Future<void> numberVacancies() async {
    final text = controller.text;
    final numeroVagas = int.tryParse(text) ?? 0;
    print(numeroVagas);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyNumberVacancies, numeroVagas);
    final teste = prefs.getInt(keyNumberVacancies);
    print('teste $teste');
    _vacanciesNumber = teste ?? 0;
    notifyListeners();
  }

  /// Get data base
  Future<void> getDb() async {
    var dba = await db.getVacancies();
    _list.clear();
    for (final pp in dba) {
      _list.add(pp);
    }
    notifyListeners();
  }

  /// Add vacancy
  void addVacancy(Vacancy vacancy) async {
    await db.add(vacancy);
    await getDb();
    notifyListeners();
  }

  /// Remove vacancy
  void removeVacancy(int idVacancy) async {
    await db.remove(idVacancy);
    await getDb();
    notifyListeners();
  }

  /// Remove all vacancy
  Future<void> removeAll(List<Vacancy> list) async {
    await db.removeAll(list);
  }

  /// Image picker
  Future<void> imagePicker() async {
    final photo = await _picker.pickImage(source: ImageSource.camera);

    if (!valueValidator(photo?.path)) {
      final file = File(photo!.path);

      final directore = await getApplicationDocumentsDirectory();

      final path = await file.copy('${directore.path}/${photo.name}');

      print('PATH >> ${path.path}');

    }

  }
}
