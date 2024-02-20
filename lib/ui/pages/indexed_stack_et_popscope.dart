import 'package:flutter/material.dart';

class IndexedStackNPopScope extends StatefulWidget {
  const IndexedStackNPopScope({super.key});

  static String routeName = "indexed_popscope";

  @override
  State<IndexedStackNPopScope> createState() => _IndexedStackNPopScopeState();
}

class _IndexedStackNPopScopeState extends State<IndexedStackNPopScope> {
  int index = 0;

  /// So, IndexedStack & PopScope don't work well together
  /// Somehow, someway, PopScope receives back navigation dispatch to other PopScopes even though they're not in view in this context
  ///

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: IndexedStack(
        index: index,
        children: [
          _IndexesWidget(
              title: "Index 0",
              onButtonPressed: () {
                setState(() {
                  index = 1;
                });
              }),
          _IndexesWidget(
            title: "Index 1",
            onBackPressed: (pop) {
              print("Pop received for Index 1 with pop value: $pop");
            },
            onButtonPressed: () {
              setState(() {
                index = 2;
              });
            },
          ),
          _IndexesWidget(
            title: "Index 2",
            onBackPressed: (pop) {
              print("Pop received for Index 2 with pop value: $pop");
            },
            onButtonPressed: () {},
          )
        ],
      ),
    );
  }
}

class _IndexesWidget extends StatelessWidget {
  final String title;
  final ValueChanged<bool>? onBackPressed;
  final VoidCallback onButtonPressed;

  const _IndexesWidget(
      {required this.title,
      required this.onButtonPressed,
      this.onBackPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    print("Building for index $title");

    Widget scaffold = Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: onButtonPressed,
          child: Text("Do stuff"),
        ),
      ),
    );

    return onBackPressed != null
        ? PopScope(onPopInvoked: onBackPressed, child: scaffold)
        : scaffold;
  }
}
