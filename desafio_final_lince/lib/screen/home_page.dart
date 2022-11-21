import 'dart:async';

import 'package:flutter/material.dart';
import '../model/provider.dart';

///Home page
class HomePage extends StatelessWidget {
  ///asdasd
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('oi'),
      ),
      body: Row(
        children: [
          const Text('oi'),
          ElevatedButton(
              onPressed: () {
                unawaited(Counter().deleteShared());
                unawaited(
                  Navigator.popAndPushNamed(context, '/InitialScreen'),
                );
              },
              child: const Text('asdasdas'))
        ],
      ),
    );
  }
}
