import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/decoration_container.dart';

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
                                await Navigator.popAndPushNamed(
                                    context, '/InitialScreen');
                                await state.deleteNumberVacancies();
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
              title: const WidgetTitle(),
            ),
            body: const WidgetVacancy(),
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

/// Class widget vacancy
class WidgetVacancy extends StatelessWidget {
  /// Constructor widget vacancy
  const WidgetVacancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);
    return ListView(
      children: state.list
          .map((e) => Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  decoration: decorationContainer(),
                  child: ListTile(
                    title: Text(e.dateTime.toString()),
                    trailing: ElevatedButton(
                      onPressed: () {
                        state.removeVacancy(e.id!);
                      },
                      child: const Icon(Icons.delete),
                    ),
                    leading: ClipRRect(
                      child: Image.asset('assets/images/iconUser.png'),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

/// Title home page
class WidgetTitle extends StatelessWidget {
  /// Title home page
  const WidgetTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(titleHomePage),
        Text(
          'Nº vagas : 2',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
