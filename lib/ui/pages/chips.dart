import 'package:flutter/material.dart';

class ChipsExample extends StatefulWidget {
  static const String routeName = "chips";

  const ChipsExample({super.key});

  @override
  State<ChipsExample> createState() => _ChipsExampleState();
}

class _ChipsExampleState extends State<ChipsExample> {
  List<int> selections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chips"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ActionChip(
              label: Text("Action Chip"),
              onPressed: () {},
            ),
            ChoiceChip(
              label: Text("A choice"),
              selected: selections.contains(1),
              disabledColor: Colors.white,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selections.add(1);
                  } else {
                    selections.remove(1);
                  }
                });
              },
            ),
            Chip(
              label: Text("A chip"),
              onDeleted: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.all(8),
              deleteIcon: Icon(Icons.close, color: Colors.black,),
            )
          ],
        ),
      ),
    );
  }
}
