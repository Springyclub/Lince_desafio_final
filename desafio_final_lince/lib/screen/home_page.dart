import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/decoration_container.dart';
import 'initial_screen.dart';

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
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return InitialScreen(state: state);
                      },
                    );

                    if (result ?? false) {
                      await state.reloadInfo();
                    }
                  },
                  child: const Icon(Icons.exit_to_app_sharp),
                )
              ],
              centerTitle: true,
              title: const WidgetTitle(),
            ),
            body: state.loading
                ? const CircularProgressIndicator()
                : const WidgetVacancy(),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.red,
              onPressed: state.hasVacancy
                  ? () async {
                      await Navigator.pushNamed(context, '/FormScreen');
                    }
                  : () {},
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
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              child: Container(
                child: ListTile(
                  subtitle: Text('Placa do carro : ${e.cardBoard}'),
                  title: Text(
                    'Nome do motorista : ${e.nameDriver}',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      state.update(e);
                    },
                    child: const Icon(Icons.delete),
                  ),
                  leading: ClipRRect(
                    child: Image.file(
                      File('/data/user/0/com.example.desafio_final_lince/'
                          'app_flutter/${e.cardBoard}'),
                    ),
                  ),
                ),
              ),
            ),
          )
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
    final state = Provider.of<MyScreenState>(context);
    return Column(
      children: [
        const Text(titleHomePage),
        Text(
          'Nº vagas : ${state.vacanciesNumber} ',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
