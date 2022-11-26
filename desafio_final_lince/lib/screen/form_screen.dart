import 'dart:async';

import 'package:flutter/material.dart';
import '../control/database.dart';
import '../control/utils/constants.dart';
import '../model/input_text_form.dart';

/// Form screen
class FormScreen extends StatefulWidget {
  ///sadad
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  /// Form screen

  @override
  Widget build(BuildContext context) {
    ///numero de vagas
    final cardBoard = TextEditingController();
    final driverName = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(titleFormCar),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                color: Colors.blue.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: driverName,
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'true';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        decoration: inputDecorationTextForm('Nome do piloto'),
                      ),
                      TextFormField(
                        controller: cardBoard,
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'true';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        decoration: inputDecorationTextForm('Nome do piloto'),
                      ),
                      ElevatedButton(
                          onPressed: () async {

                            setState(() {
                              Navigator.pop(context);
                              Navigator.popAndPushNamed(context, '/Condition');
                              add(
                                  Vacancy(name: driverName.text, cardBoard: cardBoard.text)
                              );

                            });
                          },

                          child: const Text('Adicionar')),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
