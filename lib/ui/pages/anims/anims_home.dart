import 'package:flttr_exp/ui/pages/anims/basic_rotate.dart';
import 'package:flttr_exp/ui/pages/anims/custom_drawer.dart';
import 'package:flttr_exp/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimsHome extends StatelessWidget {
  static const String routeName = "anims";

  const AnimsHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons4Pages = [
      CustomButton(buttonText: "Basic Rotate", onTap: () {
        context.goNamed(BasicRotateExample.routeName);
      }),
      CustomButton(buttonText: "Custom Drawer", onTap: () {
        context.goNamed(CustomDrawer.routeName);
      }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Anims Home"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        separatorBuilder: (ctx, index) => const SizedBox(height: 12,),
        itemCount: buttons4Pages.length,
        itemBuilder: (ctx, index) => buttons4Pages.elementAt(index),
      ),
    );
  }
}
