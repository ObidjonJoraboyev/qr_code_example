import 'package:flutter/material.dart';
import 'package:qr_code_example/screens/tab_box/tab_box.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBox(),
    );
  }
}
