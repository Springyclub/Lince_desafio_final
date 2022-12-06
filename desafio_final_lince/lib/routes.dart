 import 'package:flutter/material.dart';

import 'screen/contidion.dart';
import 'screen/form_screen.dart';
import 'screen/home_page.dart';
import 'screen/initial_screen.dart';

routes(){
  return <String, WidgetBuilder>{
   '/HomePage': (context) => const HomePage(),
   '/Condition': (context) => const Contidion(),
   '/FormScreen': (context) =>  const FormScreen(),
  };
 }