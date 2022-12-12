import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/database.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';
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
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                        ),
                        Container(
                          color: Colors.purple,
                          height: 100,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), //color of shadow
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.car_rental_sharp,
                                              size: 100,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 90, top: 90),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
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
                                    return 'Nome do motorista inválido';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                decoration: inputDecorationTextForm(
                                    'Nome do motorista inválido'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: cardBoard,
                                validator: (value) {
                                  if (valueValidator(value)) {
                                    return 'Número da placa inválido';
                                  } else if (value!.length < 7) {
                                    return 'Número da placa deve conter 7 '
                                        'digitos';
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
                                    return 'Faixa inválida';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                decoration: inputDecorationTextForm('N° faixa'),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await showModalBottomSheet<void>(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.enhance_photo_translate,
                                                size: 100,
                                              ),
                                              const Text(
                                                'É necessário uma foto do'
                                                ' veículo',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (await state
                                                          .imagePicker(
                                                        cardBoard.text
                                                            .toString(),
                                                        Vacancy(
                                                            nameDriver:
                                                                nameDriver.text,
                                                            cardBoard:
                                                                cardBoard.text,
                                                            parkingLane:
                                                                parkingLane
                                                                    .text,
                                                            dateTime:
                                                                DateTime.now()
                                                                    .toString(),
                                                            parked: 1),
                                                      )) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        await Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                '/HomePage');
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.camera_alt)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: const Text('Adicionar')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}
