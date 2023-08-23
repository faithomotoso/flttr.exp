import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flttr_exp/core/models/contacts.dart';
import 'package:flttr_exp/ui/widgets/contact_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  static const String routeName = "contacts";

  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Future<List<Contact>>? contactsFuture;
  final Dio dio = Dio();

  Future<List<Contact>> loadContacts() async {
    try {
      Response response =
          await dio.get("https://randomuser.me/api/?results=40");

      return List.from((Map.from(response.data)["results"])
          .map((c) => Contact.fromJson(json: c)));
    } on DioException catch (e) {
      log("Error loading contacts ${e.message}");
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();

    contactsFuture = loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.lightBlueAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
              color: Colors.lightBlueAccent,
            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: Colors.purple),
        child: const Text(
          "+",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Contact>>(
        future: contactsFuture,
        builder: (ctx, snapshot) {
          if ([ConnectionState.waiting, ConnectionState.active]
              .contains(snapshot.connectionState)) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Error loading contacts"),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          contactsFuture = loadContacts();
                        });
                      },
                      child: Text("Retry"))
                ],
              ),
            );
          }

          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (ctx, index) => const SizedBox(height: 12),
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (ctx, index) =>
                  ContactItem(contact: snapshot.data![index]),
            );
          }

          return const Center(
            child: Text("No contacts available"),
          );
        },
      ),
    );
  }
}
