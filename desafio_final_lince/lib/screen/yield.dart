import 'package:flutter/material.dart';

/// Class yield
class Yield extends StatelessWidget {
  /// Constructor Yield
  const Yield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rendimento por dia'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          createTable(),
        ],
      ),
    );
  }
}

/// Create table yield
Table createTable() {
  return Table(
    defaultColumnWidth: const FixedColumnWidth(150.0),
    border: const TableBorder(
      
      borderRadius: BorderRadius.all(Radius.circular(21))
    ),
    children: [
      _criarLinhaTable('Dinheiro, Hora'),
      _criarLinhaTable('4R\$, <= 2h'),
      _criarLinhaTable('3.75R \$, > 2h e <=4h'),
      _criarLinhaTable('3.50R \$, > 4h e <=8h'),
      _criarLinhaTable('8R\$, > 8h'),
    ],
  );
}

_criarLinhaTable(String listaNomes) {
  return TableRow(
    children: listaNomes.split(',').map((name) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: const TextStyle(fontSize: 20.0),
        ),
      );
    }).toList(),
  );
}
