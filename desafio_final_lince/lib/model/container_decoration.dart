import 'package:flutter/material.dart';

/// Model box decoration
BoxDecoration boxDecoationContainer(){
  return BoxDecoration(
      color: Colors.blue.shade300,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(width: 3),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade700
              .withOpacity(0.5),
          blurRadius: 4,
          offset: const Offset(5, 8),
        ),
      ]);
}