import 'package:flutter/material.dart';

/// Box decoration in container
BoxDecoration decorationContainer() {
  return BoxDecoration(
    color: Colors.teal,
    borderRadius: BorderRadius.circular(15),
    border: Border.all(width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.teal.shade700.withOpacity(0.5),
        blurRadius: 4,
        offset: const Offset(2, 4),
      ),
    ],
  );
}
