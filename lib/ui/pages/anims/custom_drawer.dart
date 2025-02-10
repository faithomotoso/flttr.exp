import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  static const String routeName = "customDrawer";

  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  // Max x positioning the widget should slide to - the right in this case
  final double maxSlide = 255.0;

  // Zero - Max displacement from the left of the screen where gestures in this area is recognized as
  // a drawer action to open the drawer
  late final double minDragStartEdge;

  // Double from the left of the screen with respect to the widget to the right where gestures in this area is recognized as
  // a drawer action to close the drawer
  late final double maxDragCloseEdge;

  // Determines if the drag action should be triggered, a factor of minDragStartEdge & maxDragStartEdge
  bool canBeDragged = false;

  final Widget drawer = Container(
    color: Colors.blue,
  );
  final Widget dash = Container(
    color: Colors.orange,
  );

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      minDragStartEdge = 50.0;
      maxDragCloseEdge = MediaQuery.of(context).size.width * 0.8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        drawer,
        GestureDetector(
          // onTap: toggleAnimation,
          onHorizontalDragStart: (details) {
            // print("Max width from media query: ${context.size?.width}");
            print("Global position dx: ${details.globalPosition.dx}");
            print("Min drag close: $maxDragCloseEdge");
            print("Animation controller status: ${animationController.status}");

            bool isDragOpenFromLeft = ([
                  AnimationStatus.forward,
                  AnimationStatus.dismissed
                ].contains(animationController.status)) &&
                details.globalPosition.dx <= minDragStartEdge;

            bool isDragCloseFromRight = [
                  AnimationStatus.completed,
                  AnimationStatus.reverse
                ].contains(animationController.status) &&
                details.globalPosition.dx >= maxDragCloseEdge;

            canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
          },
          onHorizontalDragUpdate: (details) {
            // print("Horizontal drag primary delta: ${details.primaryDelta}");
            if (canBeDragged) {
              print(
                  "Adding delta to animation controller: ${details.primaryDelta}");
              animationController.value += details.primaryDelta! / maxSlide;
              print("Animation controller value: ${animationController.value}");
            }
          },
          onHorizontalDragEnd: (details) {
            // print("ON drag end");
          },
          child: AnimatedBuilder(
            animation: animationController,
            builder: (ctx, child) {
              double slide = animationController.value * maxSlide;
              double scale = 1 - (animationController.value * 0.3);
              return Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: child,
              );
            },
            child: dash,
          ),
        )
      ],
    );
  }

  void toggleAnimation() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }
}
