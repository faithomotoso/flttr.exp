import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChipsExample extends StatefulWidget {
  static const String routeName = "chips";

  const ChipsExample({super.key});

  @override
  State<ChipsExample> createState() => _ChipsExampleState();
}

class _ChipsExampleState extends State<ChipsExample> with RestorationMixin {
  RestorableList selections = RestorableList();

  @override
  void dispose() {
    selections.dispose();
    super.dispose();
  }

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
              selected: selections.value.contains(1),
              disabledColor: Colors.white,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    ;
                    selections.value = [...selections.value, 1];
                  } else {
                    selections.value = List.from(selections.value..remove(1));
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
              deleteIcon: Icon(
                Icons.close,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  String? get restorationId => "chips.restorable";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(selections, "chip.selected");
  }
}

class RestorableList extends RestorableValue<List<int>> {
  RestorableList() {
    assert(debugIsSerializableForRestoration([]));
  }

  @override
  List<int> createDefaultValue() {
    return [];
  }

  @override
  List<int> fromPrimitives(Object? data) {
    assert(data != null);
    if (data != null) {
      return List<int>.from(data
          .toString()
          .split(",")
          .where((v) => v.isNotEmpty)
          .map((v) => int.parse(v)));
    }

    return [];
  }

  @override
  void initWithValue(List<int> value) {
    super.initWithValue(value);
    this.value = value;
  }

  @override
  Object? toPrimitives() {
    return value.join(",");
  }

  @override
  void didUpdateValue(List<int>? oldValue) {
    assert(debugIsSerializableForRestoration(value));
    notifyListeners();
  }
}
