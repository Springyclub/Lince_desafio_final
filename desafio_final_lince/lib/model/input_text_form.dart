import 'package:flutter/material.dart';

/// Input decoration text form
InputDecoration inputDecorationTextForm(String widgetSpan){
  return InputDecoration(
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
  );
}