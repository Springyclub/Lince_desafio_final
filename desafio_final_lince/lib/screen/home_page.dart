import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';

/// Home page
class HomePage extends StatelessWidget {
  /// Home page
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
                              onPressed: () async {
                                Navigator.pop(context);
                                unawaited(Navigator.popAndPushNamed(
                                    context, '/InitialScreen'));
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
            body: const WidgetVacancies(),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.red,
              onPressed: () async {
                await Navigator.pushNamed(context, '/FormScreen');
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

/// Widget vacancy
class WidgetVacancies extends StatelessWidget {
  /// Constructor widget vacancy
  const WidgetVacancies({super.key});

  ///TESTE
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);

    return state.loading
        ? const CircularProgressIndicator()
        : ListView(
            children: [
              Text(''),
              ElevatedButton(
                onPressed: (){
                  state.getPerson();
                },
                child: const Text(''),
              )
            ],
          );
  }
}
