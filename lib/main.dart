import 'package:flttr_exp/router_config.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

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
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flttr Exp',
      restorationScopeId: "app.restoration.id",
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.orange,
      ),
    );
  }
}
