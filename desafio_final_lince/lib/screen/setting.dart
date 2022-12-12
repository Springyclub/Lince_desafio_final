import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';
import 'initial_screen.dart';

/// Settings
class Settings extends StatelessWidget {
  /// Constructor settings
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyScreenState(),
      child: Consumer<MyScreenState>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Configurações'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      gradient: LinearGradient(colors: [
                                        Colors.purple.shade100,
                                        Colors.blue.shade100,
                                      ])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'N° Vagas',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${state.occupied}',
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w900,
                                                ),
                                              ),
                                              const Text(
                                                ' livres',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 15.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(
                                          0,
                                          6,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'N° Vagas',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5),
                                              child: Text(
                                                '${state.list.length}',
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight:
                                                      FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              ' ocupadas',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w900),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom),
                          child: InitialScreen(state: state),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.numbers_sharp,
                          size: 50,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Mudar numero de vagas',
                          style: TextStyle(fontSize: 20),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_upward)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/YieldPerDay');
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.monetization_on,
                          size: 50,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Rendimento p/ dia',
                          style: TextStyle(fontSize: 20),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/ListCar');
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.car_crash,
                          size: 50,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Carros registrados',
                          style: TextStyle(fontSize: 20),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/Yield');
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.table_chart,
                          size: 50,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Tabela de rendimento',
                          style: TextStyle(fontSize: 20),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
