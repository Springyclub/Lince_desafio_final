import 'dart:io';

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
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/Settings');
                  },
                  child: const Icon(Icons.settings),
                )
              ],
              centerTitle: true,
              title: const WidgetTitle(),
            ),
            body: const WidgetVacancy(),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.red,
              onPressed: state.vacanciesNumber > state.length
                  ? () async {
                      await Navigator.pushNamed(context, '/FormScreen');
                    }
                  : () {
                final snackBar = SnackBar(
                  content: const Text('Cadrastre mais vagas em opções'),
                  action: SnackBarAction(
                    label: 'Fechar',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return state.list.isNotEmpty
        ? ListView(
            children: state.list
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 20,
                    ),
                    child: Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade100,
                              Colors.blue.shade100,
                            ])),
                        child: ListTile(
                          iconColor: Colors.black,
                          leading: const Icon(
                            Icons.directions_car,
                            size: 60,
                          ),
                          title: Text('Vaga : ${e.parkingLane}'),
                          subtitle: Text(
                            'Entrada : '
                            '${e.dateTime}',
                            style: const TextStyle(fontSize: 10),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Text('Faixa: ${e.parkingLane}'),
                                        Text('Nome : ${e.nameDriver}'),
                                        Text('Placa : ${e.cardBoard}'),
                                        Text('Está estacionado :'
                                            ' ${e.parked == 1 ? 'sim' : ''
                                                'não'}'),
                                        Text(
                                          'Entrada : '
                                          '${e.dateTime}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    buttonPadding: const EdgeInsets.all(30),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        child: Image.file(
                                                          File('/data/user/0/'
                                                              'com.example.d'
                                                              'esafio_final_'
                                                              'lince'
                                                              '/app_flutter/'
                                                              '${e.cardBoard}'
                                                              '.jpg'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 200,
                                                        ),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'X')),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: const Text('Ver placa'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await state.removeList(
                                              e.id!, e.dateTime, e.parked, e);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              // Change your radius here
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Remover',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  // Change your radius here
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            child: const Text('Detalhes'),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.car_crash_outlined,
                size: 300,
                color: Colors.black.withOpacity(0.6),
              ),
              const Text(
                'Não há carros cadastrados',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ));
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
        !state.loading
            ? Text(
                'Nº vagas :'
                ' ${state.vacanciesNumber}/'
                '${state.length}',
                style: const TextStyle(fontSize: 15),
              )
            : const CircularProgressIndicator(
                color: Colors.orange,
              ),
      ],
    );
  }
}
