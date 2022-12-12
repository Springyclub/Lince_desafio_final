import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'utils/constants.dart';

///...
class MyScreenState extends ChangeNotifier {
  /// Init method
  MyScreenState() {
    unawaited(_init());
  }

  /// Has parked validate
  int hasPark = 0;

  final ImagePicker _picker = ImagePicker();

  /// Data base helper
  DatabaseHelper db = DatabaseHelper.instance;

  /// List vacancy to homPage
  final List<Vacancy> _list = [];

  final List<Vacancy> _listHasPark = [];

  /// Get list vacancy
  List<Vacancy> get list => _list;

  /// List vacancy Has park
  List<Vacancy> get listHasPark => _listHasPark;

  /// Has vacancy
  bool get hasVacancy => _vacanciesNumber != 0;

  /// Length list
  int get length => hasPark;

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
    await yieldPerDay();
    await getDb();
    final prefs = await SharedPreferences.getInstance();
    _vacanciesNumber = prefs.getInt(keyNumberVacancies) ?? 0;
    _loading = false;
    notifyListeners();
  }

  /// Reload info
  Future<void> reloadInfo() async {
    notifyListeners();
  }

  /// Delete number vacancies
  Future<void> deleteNumberVacancies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyNumberVacancies);
    notifyListeners();
  }

  /// Number vacancies
  Future<void> numberVacancies() async {
    final text = controller.text.toUpperCase();
    final numeroVagas = int.tryParse(text) ?? 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyNumberVacancies, numeroVagas);
    final teste = prefs.getInt(keyNumberVacancies);
    _vacanciesNumber = teste ?? 0;
    notifyListeners();
  }

  /// Get data base
  Future<void> getDb() async {
    var dba = await db.getVacancies();
    _list.clear();
    hasPark = 0;
    for (final pp in dba) {
      _listHasPark.add(pp);
      _list.add(pp);
      if (pp.parked == 0) {
        _list.remove(pp);
      }

      if (pp.parked == 1) {
        hasPark += 1;
        _listHasPark.remove(pp);
      }
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
  void removeVacancy(int idVacancy, Vacancy vacancy) async {
    await db.remove(idVacancy);
    _list.remove(vacancy);
    await getDb();
    notifyListeners();
  }

  /// Remove list vacancy
  Future<void> removeList(
      int id, String entryDate, int parked, Vacancy vacancy) async {
    final diff = int.parse(DateTime.now()
        .difference(DateTime.parse(entryDate))
        .inHours
        .toString());
    if (diff <= 2) {
      await db.removeList(id, DateTime.now().toString(), 4);
    } else if (diff > 2 && diff <= 4) {
      await db.removeList(id, DateTime.now().toString(), 3.75);
    } else if (diff > 4 && diff <= 8) {
      await db.removeList(id, DateTime.now().toString(), 3.50);
    } else if (diff > 8) {
      await db.removeList(id, DateTime.now().toString(), 8);
    }
    await getDb();
    notifyListeners();
  }

  /// Image picker
  Future<bool> imagePicker(String photos, Vacancy vacancy) async {
    final photo = await _picker.pickImage(source: ImageSource.camera);
    if (!valueValidator(photo?.path)) {
      final file = File(photo!.path);

      final directore = await getApplicationDocumentsDirectory();

      await file.copy('${directore.path}/$photos.jpg');
      await db.add(vacancy);
      await getDb();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  /// Delete image
  Future<void> deleteImage(String photo) async {
    final directore = await getApplicationDocumentsDirectory();

    final file = File('${directore.path}/$photo');
    await file.delete();
  }

  /// Yield per day
  Future<void> yieldPerDay() async {
    /// Data base get prices
    final dba = await db.getPrices();
    _listYield.clear();
    for (final asd in dba) {
      _listYield.add(asd);
    }
  }

  /// List yield
  final List<Income> _listYield = [];

  /// Get list yield
  List<Income> get listYield => _listYield;

  /// Vacancy occupied
  int get occupied => vacanciesNumber - list.length;
}
