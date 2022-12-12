import 'package:flutter/material.dart';

/// Input decoration text form
InputDecoration inputDecorationTextForm(String widgetSpan) {
  return InputDecoration(
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(21))),
    errorStyle: const TextStyle(
      backgroundColor: Colors.white,
      color: Colors.red,
      fontWeight: FontWeight.bold,
      wordSpacing: 3.0,
    ),
    label: Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              widgetSpan,
              style: const TextStyle(backgroundColor: Colors.white),
            ),
          ),
          const WidgetSpan(
            child: Text(
              '*',
              style:
                  TextStyle(color: Colors.red, backgroundColor: Colors.white),
            ),
          ),
        ],
      ),
    ),
    fillColor: Colors.white,
    filled: true,
  );
}
