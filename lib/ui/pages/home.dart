import 'package:flttr_exp/ui/pages/sliver_list_w_headers.dart';
import 'package:flttr_exp/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_button_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  context.goNamed(CustomButtonPage.routeName);
                },
                child: Text("To custom button")),
            CustomButton(
                buttonText: "To custom button page?",
                onTap: () {
                  context.goNamed(CustomButtonPage.routeName);
                }),
            CustomButton(
                buttonText: "To slivers page",
                onTap: () {
                  context.goNamed(SliverListWHeaders.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
