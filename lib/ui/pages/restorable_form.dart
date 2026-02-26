import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RestorableForm extends StatefulWidget {
  static const String routeName = "restorable-form";

  const RestorableForm({super.key});

  @override
  State<RestorableForm> createState() => _RestorableFormState();
}

class _RestorableFormState extends State<RestorableForm> with RestorationMixin {
  final RestorableTextEditingController nameController =
      RestorableTextEditingController();
  final RestorableTextEditingController numberController =
      RestorableTextEditingController();
  final ValueNotifier<Future<List<String>>?> dropdownOptionsFuture =
      ValueNotifier(null);
  final RestorableStringN selectedItem = RestorableStringN(null);
  RestorableStringN selectedImagePath = RestorableStringN(null);

  @override
  void initState() {
    fetchDropdownOptions();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    dropdownOptionsFuture.dispose();
    selectedItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restorable form"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
            valueListenable: dropdownOptionsFuture,
            builder: (ctx, future, _) {
              return FutureBuilder(
                  future: future,
                  builder: (ctx, snapshot) {
                    if ([ConnectionState.active, ConnectionState.waiting]
                        .contains(snapshot.connectionState)) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData) {
                      return ListView(
                        children: [
                          TextFormField(
                            controller: nameController.value,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: numberController.value,
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButton<String>(
                            onChanged: (v) {},
                            value: selectedItem.value,
                            items: List<DropdownMenuItem<String>>.from(
                              snapshot.data!.map(
                                (d) => DropdownMenuItem<String>(
                                  key: ValueKey(d),
                                  value: d,
                                  onTap: () {
                                    setState(() {
                                      selectedItem.value = d;
                                    });
                                  },
                                  child: Text(d),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FilledButton(
                              onPressed: selectImage,
                              child: Text("Select image")),
                          if (selectedImagePath.value != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Image.file(
                                File(selectedImagePath.value!),
                                height: 300,
                              ),
                            ),
                        ],
                      );
                    }

                    return const SizedBox();
                  });
            }),
      )),
    );
  }

  @override
  String? get restorationId => "form.restorable";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(nameController, "name.restorable.controller");
    registerForRestoration(numberController, "number.restorable.controller");
    registerForRestoration(selectedItem, "dropdown.selected.item");
    registerForRestoration(selectedImagePath, "selected.image.path");
  }

  void fetchDropdownOptions() {
    dropdownOptionsFuture.value =
        Future<List<String>>.delayed(const Duration(seconds: 4), () {
      return ["Apple", "Oranges"];
    });
  }

  Future<void> selectImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        selectedImagePath.value = file.path;
      });
    }
  }
}
