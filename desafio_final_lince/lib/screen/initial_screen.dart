import 'dart:async';

import 'package:flutter/material.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/input_text_form.dart';

/// class initial screen
class InitialScreen extends StatelessWidget {
  /// Constructor initial screen
  const InitialScreen({
    super.key,
    required this.state,
  });

  /// My screen state
  final MyScreenState state;

  /// Number vacancy
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              const Text(
                'Qual o numero de vagas?',
                style: TextStyle(
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            inputDecorationTextForm('Insira o numero de vagas'),
                        controller: state.controller,
                        validator: (value) {
                          if (numberValidator(value)) {
                            if (int.parse(state.controller.text) <
                                state.length) {
                              return 'Existe um numero maior de vagas';
                            }
                            return null;
                          }
                          return 'Insira número válidos';
                        },
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            unawaited(Navigator.popAndPushNamed(
                                context, '/HomePage'));
                            await state.numberVacancies();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple.shade100),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              // Change your radius here
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(color: Colors.black),
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
    );
  }
}
