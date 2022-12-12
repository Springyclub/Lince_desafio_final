import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';

/// Class Yield per day
class YieldPerDay extends StatelessWidget {
  /// Constructor Yield per day
  const YieldPerDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyScreenState(),
        child: Consumer<MyScreenState>(builder: (_, state, __) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Rendimento por dia'),
              ),
              body: const ListViweYield());
        }));
  }
}

/// List Viwe Yield
class ListViweYield extends StatelessWidget {
  /// Constructor List Viwe Yield
  const ListViweYield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);
    return state.listYield.isNotEmpty
        ? ListView.builder(
            itemCount: state.listYield.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  elevation: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.alarm,
                                  size: 35,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    DateFormat('d/M/yyy').format(
                                      DateTime.parse(
                                        state.listYield[index].dayYield
                                            .toString(),
                                      ),
                                    ),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  Valor: '
                                        '${state.listYield[index].valueYield}'
                                    ' R\$',
                                    style: const TextStyle(fontSize: 20),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.money_off_csred,
                size: 300,
                color: Colors.black.withOpacity(0.6),
              ),
              const Text(
                'Não há rendimento',
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
