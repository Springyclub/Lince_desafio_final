import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../control/database.dart';
import '../control/provider.dart';
import '../control/utils/constants.dart';
import '../model/input_text_form.dart';
import 'package:image_picker/image_picker.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                    color: Colors.blue.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          TextFormField(
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
                          TextFormField(
                            controller: cardBoard,
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
                          ElevatedButton(
                              onPressed: () async{
                                await state.imagePicker();
                              },
                              child: const Icon(Icons.camera_alt)),
                          ElevatedButton(
                              onPressed: () async {
                                state.addVacancy(
                                  Vacancy(
                                      nameDriver: nameDriver.text,
                                      cardBoard: cardBoard.text,
                                      parkingLane: nameDriver.text,
                                      dateTime: DateTime.now().toString()),
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
          ),
        );
      }),
    );
  }
}
