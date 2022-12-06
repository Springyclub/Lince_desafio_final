import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  ///numero de vagas
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: state,
      child: Consumer<MyScreenState>(
        builder: (_, state, __) {
          return Material(
            color: const Color.fromARGB(0, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.only(right: 50,left: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(width: 1),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: const [
                          Text(
                            'Qual o numero de vagas?',
                            style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow. fade,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if( int.parse(state.controller.text) < state.lenght){
                  return null;
                }
                await state.numberVacancies();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: const Text('Confirmar'),
          ),
        ),
      ],
    );
  }
}
