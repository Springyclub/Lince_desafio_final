 import 'package:desafio_final_lince/screen/contidion.dart';
import 'package:desafio_final_lince/screen/form_screen.dart';
import 'package:desafio_final_lince/screen/home_page.dart';
import 'package:desafio_final_lince/screen/initial_screen.dart';
import 'package:flutter/material.dart';

routes(){
  return <String, WidgetBuilder>{
   '/InitialScreen': (context) => const InitialScreen(),
   '/HomePage': (context) => const HomePage(),
   '/Condition': (context) => const Contidion(),
   '/FormScreen': (context) =>  const FormScreen(),
  };
 }