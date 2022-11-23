import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';

///Home page
class HomePage extends StatelessWidget {
  ///asdasd
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyScreenState(),
      child: Consumer<MyScreenState>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                ElevatedButton(
                  onPressed: () {
                    unawaited(showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(titleAlertDialog),
                          content: const Text(contentAlertDiolog),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(textCancelButtonAlertDialog),

                            ),
                            ElevatedButton(
                              onPressed: () {
                                unawaited(state.deleteNumberVacancies());
                              },
                              child: const Text(textConfirmeButtonAlertDialog),

                            )
                          ],
                        );
                      },
                    ));

                  },
                  child: const Icon(Icons.exit_to_app_sharp),
                )
              ],
              centerTitle: true,
              title: const Text(titleHomePage),
            ),
            body: state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(child: WidgetVacuns()),
                    ],
                  ),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.red,
              onPressed: () {
                unawaited(Navigator.pushNamed(context, '/FormScreen'));
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

///TESTE
class WidgetVacuns extends StatelessWidget {
  ///TESTE
  const WidgetVacuns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);

    return Text(
      state.vacanciesNumber.toString(),
      style: const TextStyle(fontSize: 30),
    );
  }
}
