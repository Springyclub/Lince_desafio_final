import 'package:flutter/material.dart';

import '../control/utils/constants.dart';
import 'package:desafio_final_lince/model/input_text_form.dart';

/// Form screen
class FormScreen extends StatelessWidget {
  /// Form screen

  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///numero de vagas
    final parkingLane = TextEditingController();
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
                        validator: (value) {
                          if(valueValidator(value)){
                            return 'true';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        decoration: inputDecorationTextForm('Nome do piloto'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if(valueValidator(value)){
                            return 'true';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        decoration: inputDecorationTextForm('Nome do piloto'),
                      ),
                      TextFormField(
                        validator: (value) {
                          if(valueValidator(value)){
                            return 'true';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        decoration: inputDecorationTextForm('Nome do piloto'),
                      ),

                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }


  
  }


