import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/database.dart';
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
                                Navigator.popAndPushNamed(context, '/InitialScreen');
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
                ? const CircularProgressIndicator()
                : FutureBuilder<List<Vacancy>>(
                    future: getVacancy(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text('data');
                        case ConnectionState.waiting:
                          return Center(
                            child: Container(
                              margin: const EdgeInsetsDirectional.all(150),
                              child: const CircularProgressIndicator(),
                            ),
                          );
                        case ConnectionState.active:
                          return const Text('data');
                        case ConnectionState.done:
                          return snapshot.data == null
                              ? const Center(
                                  child: Text('TÁ VÁZIO'),
                                )
                              : ListView(
                                  children: snapshot.data!.map((vacancy) {
                                  return Center(
                                      child: ListTile(
                                    title: Column(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              state.notifyListeners();
                                              remove(vacancy.id!);
                                            },
                                            child: const Text('')),
                                        Text(vacancy.name.toString()),
                                        Text(vacancy.id.toString()),
                                        Text(vacancy.cardBoard.toString()),
                                      ],
                                    ),
                                  ));
                                }).toList());
                      }
                    },
                  ),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, '/FormScreen');
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
class WidgetVacancies extends StatelessWidget {
  ///TESTE
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);

    return state.loading
        ? const CircularProgressIndicator()
        : Row(
            children: [

              Text(
                state.vacanciesNumber.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            ],
          );
  }
}
