import 'package:flutter/material.dart';

import '../control/utils/constants.dart';

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
                      action(
                        parkingLane,
                        'Faixa de estacionamento',
                        teste(3)
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  /// Text Form Field
  TextFormField action(
      TextEditingController controllerText, String widgetSpan, dynamic vali) {
    return TextFormField(
      controller: controllerText,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          wordSpacing: 3.0,
        ),
        label: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              WidgetSpan(
                child: Text(widgetSpan),
              ),
              const WidgetSpan(
                child: Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}

teste(int a){
  if(a>3){
    Text(a.toString());
  }
}