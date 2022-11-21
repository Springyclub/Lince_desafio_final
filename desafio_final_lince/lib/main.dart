import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/provider.dart';
import 'screen/home_page.dart';
import 'screen/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

///sdasd
class MyApp extends StatefulWidget {
  ///constructor
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/InitialScreen': (context) => const InitialScreen(),
        '/HomePage': (context) => const HomePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        ////fontFamily: , A fazer
        primarySwatch: Colors.purple,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Counter(),
          ),
        ],
        child: FutureBuilder<int?> (
          future: Counter().readShared(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return const Text('aasdas');
              case ConnectionState.waiting:
                return const Text('oi');

              case ConnectionState.active:
                return const Text('oi');

              case ConnectionState.done:
                if(Counter().numberValidator(Counter().readShared.toString())){
                  return const InitialScreen();

                }else{
                  return const HomePage();

                }
            }
          },
        ),
      ),
    );
  }
}
