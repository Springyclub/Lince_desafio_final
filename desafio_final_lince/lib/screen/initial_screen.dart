import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/container_decoration.dart';
import '../model/input_text_form.dart';

///OIOIOIOIOIOI
class InitialScreen extends StatefulWidget {
  ///OIOIOI
  const InitialScreen({super.key});

  ///titulo do app

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  ///numero de vagas
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyScreenState(),
      child: Consumer<MyScreenState>(
        builder: (_, state, __) {
          return Form(
            key: formKey,
            child: Scaffold(
              body: state.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 200,
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          decoration: boxDecoationContainer(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Padding(
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
                                padding: EdgeInsets.all(20),
                                child: Widget1(),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

///askdjnals
class Widget1 extends StatelessWidget {
  ///jsadhsakdhak
  const Widget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyScreenState>(context);

    return Column(
      children: [
        Center(
          child: TextFormField(
            controller: state.controller,
            validator: (value) {
              if (numberValidator(value)) {
                return null;
              }
              return 'Insira número válidos';
            },
            textAlign: TextAlign.start,
            decoration: inputDecorationTextForm('Numero de vagas'),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                unawaited(state.numberVacancies());
                 await Navigator.of(context)
                    .popAndPushNamed('/HomePage');
              }
            },
            child: const Text('Confirmar')),
      ],
    );
  }
}
