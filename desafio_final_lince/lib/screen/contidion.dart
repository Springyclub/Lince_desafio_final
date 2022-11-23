import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';
import 'home_page.dart';
import 'initial_screen.dart';

///Contidion screen
class Contidion extends StatelessWidget {
  ///Contidion screen
  const Contidion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyScreenState(),
        child: Consumer<MyScreenState>(builder: (_, state, __) {
          return state.vacanciesNumber == 0
              ? const InitialScreen()
              : const HomePage();
        }));
  }
}
