import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/database.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/decoration_container.dart';
import '../model/input_text_form.dart';

/// Form screen
class FormScreen extends StatelessWidget {
  ///sadad
  const FormScreen({super.key});

  /// Form screen

  @override
  Widget build(BuildContext context) {
    ///numero de vagas
    final cardBoard = TextEditingController();
    final nameDriver = TextEditingController();
    final parkingLane = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
      create: (_) => MyScreenState(),
      child: Consumer<MyScreenState>(builder: (_, state, __) {
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(titleFormCar),
            ),
            body: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(left: 50, right: 50, top: 70),
                  decoration: decorationContainer(),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nameDriver,
                            validator: (value) {
                              if (valueValidator(value)) {
                                return 'true';
                              }
                              return null;
                            },
                            textAlign: TextAlign.start,
                            decoration:
                                inputDecorationTextForm('Nome do piloto'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: cardBoard,
                            validator: (value) {
                              if (valueValidator(value)) {
                                return 'true';
                              }
                              return null;
                            },
                            textAlign: TextAlign.start,
                            decoration:
                                inputDecorationTextForm('Placa do carro'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: parkingLane,
                            validator: (value) {
                              if (valueValidator(value)) {
                                return 'true';
                              }
                              return null;
                            },
                            textAlign: TextAlign.start,
                            decoration: inputDecorationTextForm('N° faixa'),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: (){
                              state.imagePicker(cardBoard.text.toString());
                            },
                            child: const Icon(Icons.camera_alt)),
                        ElevatedButton(
                            onPressed: () async {
                              state.addVacancy(
                                Vacancy(
                                    nameDriver: nameDriver.text,
                                    cardBoard: cardBoard.text,
                                    parkingLane: nameDriver.text,
                                    dateTime: DateTime.now().toString(),
                                  parked: 1
                                ),
                              );
                              Navigator.pop(context);
                              await Navigator.popAndPushNamed(
                                  context, '/HomePage');
                            },
                            child: const Text('Adicionar')),
                      ],
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}
