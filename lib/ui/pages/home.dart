import 'package:flttr_exp/ui/pages/anims/anims_home.dart';
import 'package:flttr_exp/ui/pages/animated_list_exmp.dart';
import 'package:flttr_exp/ui/pages/cancel_http_page.dart';
import 'package:flttr_exp/ui/pages/sliver_list_w_headers.dart';
import 'package:flttr_exp/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'chips.dart';
import 'contacts_page.dart';
import 'custom_button_page.dart';
import 'indexed_stack_et_popscope.dart';

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
        child: SingleChildScrollView(
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
              CustomButton(
                  buttonText: "To animated list exmp page",
                  onTap: () {
                    context.goNamed(AnimatedListExmp.routeName);
                  }),
              CustomButton(
                  buttonText: "To contacts page",
                  onTap: () {
                    context.goNamed(ContactsPage.routeName);
                  }),
              CustomButton(
                  buttonText: "To chips example",
                  onTap: () {
                    context.goNamed(ChipsExample.routeName);
                  }),
              CustomButton(
                  buttonText: "To IndexedStackNPopScope page",
                  onTap: () {
                    context.goNamed(IndexedStackNPopScope.routeName);
                  }),
              CustomButton(
                  buttonText: "To Anims page",
                  onTap: () {
                    context.goNamed(AnimsHome.routeName);
                  }),
              CustomButton(
                  buttonText: "To cancel http page",
                  onTap: () {
                    context.goNamed(CancelHttpPage.routeName);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
