import 'package:flutter/material.dart';

import 'screen/form_screen.dart';
import 'screen/home_page.dart';
import 'screen/list_car.dart';
import 'screen/setting.dart';
import 'screen/yield.dart';
import 'screen/yield_per_day.dart';

/// Routes
Map<String, WidgetBuilder> routes() {
  return <String
  , WidgetBuilder>{
  '/HomePage': (context) => const HomePage(),
  '/FormScreen': (context) => const FormScreen(),
  '/Settings' : (context) => const Settings(),
  '/ListCar': (context) => const ListCar(),
  '/Yield': (context) => const Yield(),
  '/YieldPerDay': (context) => const YieldPerDay(),
  };
}