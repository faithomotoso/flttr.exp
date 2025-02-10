import 'package:flttr_exp/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BasicRotateExample extends StatefulWidget {
  static const String routeName = "basicRotate";

  const BasicRotateExample({super.key});

  @override
  State<BasicRotateExample> createState() => _BasicRotateExampleState();
}

class _BasicRotateExampleState extends State<BasicRotateExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  final Widget btn = CustomButton(
    buttonText: "Weeee",
    onTap: () {},
  );

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addStatusListener((status) {
            print(status);
          });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Rotate"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (ctx, child) => Transform.rotate(
                angle: animationController.value * math.pi,
                child: child,
              ),
              child: btn,
            ),
            const SizedBox(
              height: 12,
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (ctx, child) => Transform(
                transform: Matrix4.identity(),
                child: child,
              ),
              child: btn,
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
              buttonText: "Trigger animation",
              onTap: () {
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
