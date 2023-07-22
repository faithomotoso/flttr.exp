import 'dart:developer';

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onTap;

  const CustomButton({
    required this.buttonText,
    required this.onTap,
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController translateController;
  late Animation<Offset> offsetAnimation;
  final Offset shadowOffset = const Offset(6, 6);

  @override
  void initState() {
    super.initState();
    translateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    offsetAnimation = Tween<Offset>(begin: Offset.zero, end: shadowOffset)
        .animate(translateController);
  }

  @override
  void dispose() {
    translateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      // height: 100,
      // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(color: Colors.pink, offset: shadowOffset),
          ],
          borderRadius: BorderRadius.circular(14)),
      // duration: const Duration(milliseconds: 300),
      child: AnimatedBuilder(
        animation: translateController,
        builder: (ctx, child) {
          return GestureDetector(
              onTapDown: (details) {
                // print("On tap");
                translateController.forward();
                widget.onTap();
              },
              onTapCancel: () {
                // print("On tap cancel");
                translateController.reverse();
              },
              onTapUp: (details) {
                // print("On tap up");
                translateController.reverse();
              },
              child: Transform.translate(
                  offset: offsetAnimation.value,
                  child: child));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black)),
          // constraints: const BoxConstraints(minWidth: 100),
          child: Text(widget.buttonText),
        ),
      ),
    );
  }
}
