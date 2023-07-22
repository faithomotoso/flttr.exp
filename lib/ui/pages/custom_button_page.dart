import 'package:flttr_exp/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomButtonPage extends StatelessWidget {
  const CustomButtonPage({super.key});

  static const String routeName = "custom-btn-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomButton(
            buttonText: "Click Me",
            onTap: () {
              print("Button clicked");
            },
          ),
        ]),
      ),
    );
  }
}
