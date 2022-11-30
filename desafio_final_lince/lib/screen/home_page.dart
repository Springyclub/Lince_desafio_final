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
                                Navigator.popAndPushNamed(
                                    context, '/InitialScreen');
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
            body: WidgetVacancies(),
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

    return ListView(
      children: state.list
          .map((data) => CircleAvatar(
        minRadius: 50.0,
        backgroundColor: Colors.red,
        child: Text(data,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            )),
      ))
          .toList(),
    );
  }
}
