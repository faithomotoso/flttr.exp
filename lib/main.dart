import 'package:flttr_exp/router_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterConfiguration,
      title: 'Flttr Exp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
