import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';

/// List car
class ListCar extends StatelessWidget {
  /// Constructor list car
  const ListCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyScreenState(),
      child: Consumer<MyScreenState>(
        builder: (_, state, __) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Lista de carros'),
              ),
              body: state.listYield.isNotEmpty
                  ? const WidgetList()
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
                    )));
        },
      ),
    );
  }
}

/// Widget list car
class WidgetList extends StatelessWidget {
  /// Constructor widget vacancy
  const WidgetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);

    return GroupedListView(
      elements: state.listHasPark,
      groupBy: (element) {
        return DateFormat('EEEE MMM d yyy')
            .format(DateTime.parse(element.dateTime))
            .toString();
      },
      groupComparator: (value1, value2) => value2.compareTo(value1),
      groupSeparatorBuilder: (value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, e) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
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
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                                                        const EdgeInsets.only(
                                                      left: 200,
                                                    ),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('X')),
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
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.red),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    // Change your radius here
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Fechar',
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
        );
      },
    );
  }
}
