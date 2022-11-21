import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///first class
class Counter extends ChangeNotifier {
  ///save Shared
  Future<void> saveShared(int vacancies) async {
    final prefs = await SharedPreferences.getInstance();
    await (prefs.setInt('vacancies', vacancies));
  }

  ///delete Shared
  Future<void> deleteShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('vacancies');
    notifyListeners();
  }

  ///read Shared
  Future<int?> readShared() async {
    final prefs = await SharedPreferences.getInstance();
    late int? vacancies = prefs.getInt('vacancies');
    return vacancies;
  }

  ///validador de numero FormField
  bool numberValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }
}

