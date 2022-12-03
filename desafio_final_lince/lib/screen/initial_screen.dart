import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/decoration_container.dart';
import '../model/input_text_form.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({
    super.key,
    required this.state,
  });

  final MyScreenState state;

  ///numero de vagas
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: state,
      child: Consumer<MyScreenState>(
        builder: (_, state, __) {
          return Material(
            child: Container(
              decoration: decorationContainer(),
              child: Form(
                key: formKey,
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
              await state.numberVacancies();
              // ignore: use_build_context_synchronously
              Navigator.pop(context, true);
            }
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
