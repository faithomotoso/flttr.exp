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
  final ValueNotifier<bool> isHovering = ValueNotifier(false);
  final Color hoverColor =
      Color.alphaBlend(Colors.pink.withValues(alpha: 0.1), Colors.white);

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
      decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(color: Colors.pink, offset: shadowOffset),
          ],
          borderRadius: BorderRadius.circular(14)),
      child: AnimatedBuilder(
        animation: translateController,
        builder: (ctx, child) {
          return InkWell(
              onTapDown: (details) {
                // print("On tap");
                translateController.forward();
              },
              onTapCancel: () {
                // print("On tap cancel");
                translateController.reverse();
              },
              onTapUp: (details) {
                // print("On tap up");
                translateController.reverse();
                widget.onTap();
              },
              onHover: (h) {
                isHovering.value = h;
              },
              overlayColor:
                  const WidgetStatePropertyAll<Color>(Colors.transparent),
              child: Transform.translate(
                  offset: offsetAnimation.value, child: child));
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: isHovering,
          builder: (ctx, hovering, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  color: hovering ? hoverColor : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black)),
              child: Text(widget.buttonText),
            );
          },
        ),
      ),
    );
  }
}
