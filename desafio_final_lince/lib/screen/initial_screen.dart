import 'dart:async';

import 'package:flutter/material.dart';
import '../model/provider.dart';

///OIOIOIOIOIOI
class InitialScreen extends StatefulWidget {
  ///OIOIOI
  const InitialScreen({super.key});

  ///titulo do app

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _formKey = GlobalKey<FormState>();

  ///numero de vagas
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 200,
              left: 20,
              right: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade700.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(5, 8),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Qual o numero de vagas?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: numberController,
                      validator: (value) {
                        if (Counter().numberValidator(value)) {
                          return 'Insira número válidos';
                        }
                        return null;
                      },
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 3.0,
                        ),
                        label: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: Text('Número de vagas'),
                              ),
                              WidgetSpan(
                                child: Text(
                                  '*',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        unawaited(
                          Navigator.of(context).popAndPushNamed('/HomePage'),
                        );
                        if (_formKey.currentState!.validate()) {
                          unawaited(
                            Counter().saveShared(
                              int.parse(numberController.text),
                            ),
                          );
                        }
                      },
                      child: const Text('Confirmar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
