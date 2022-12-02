import 'package:desafio_final_lince/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'control/database.dart';
import 'control/provider.dart';
import 'screen/contidion.dart';
import 'screen/form_screen.dart';
import 'screen/home_page.dart';
import 'screen/initial_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

///sdasd
class MyApp extends StatefulWidget {
  ///constructor
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes(),
      title: 'Flutter Demo',
      theme: ThemeData(
        ////fontFamily: , A fazer
        primarySwatch: Colors.purple,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MyScreenState(),
          ),
        ],
        child: const Contidion(),
      ),
    );
  }
}
