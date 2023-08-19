import 'dart:math';

import 'package:flttr_exp/ui/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AnimatedListExmp extends StatefulWidget {
  static const String routeName = "animated.list.exmp";

  const AnimatedListExmp({super.key});

  @override
  State<AnimatedListExmp> createState() => _AnimatedListExmpState();
}

class _AnimatedListExmpState extends State<AnimatedListExmp> {
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();
  final Uuid uuid = Uuid();
  final List<MessageModel> messages = [];
  final TextEditingController composeMessageController =
      TextEditingController();
  final ScrollController animatedListScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Prepopulate messages
    messages..addAll([
      MessageModel(
        id: uuid.v4(),
        message: "Hi there",
        createdAt: DateTime.now().subtract(
          const Duration(minutes: 13),
        ),
      ),
      MessageModel(
          id: uuid.v4(),
          message: "How do you do?",
          createdAt: DateTime.now().subtract(
            const Duration(minutes: 11),
          ),
          isMeSender: false),
      MessageModel(
        id: uuid.v4(),
        message: "Not bad",
        createdAt: DateTime.now().subtract(
          const Duration(minutes: 9),
        ),
      ),
    ])..sort((m1, m2) => m2.createdAt.compareTo(m1.createdAt));

    dummyBrainiac();
  }

  void dummyBrainiac() async {
    // Simulate receiving messages at intervals
    int seconds = Random().nextInt(30);

    await Future.delayed(Duration(seconds: seconds));
    int randomMsgIndex = Random().nextInt(messages.length - 1);
    sendMessage(messages.elementAt(randomMsgIndex).message, isMeSender: false);

    dummyBrainiac();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated list example"),
      ),
      body: Column(
        children: [
          Expanded(
              child: AnimatedList(
            key: animatedListKey,
            controller: animatedListScrollController,
            initialItemCount: messages.length,
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: MessageWidget(
                    messageModel: messages.elementAt(index),
                    animation: animation),
              );
            },
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: composeMessageController,
                  onSubmitted: (txt) {
                    sendMessage(txt);
                    composeMessageController.clear();
                  },
                  decoration: InputDecoration(
                      hintText: "Compose message",
                      fillColor: Colors.black12.withOpacity(0.04),
                      filled: true),
                ),
              ),
              IconButton(
                  onPressed: () {
                    // Send message here
                    sendMessage(composeMessageController.text);
                    composeMessageController.clear();
                  },
                  icon: Icon(Icons.send_outlined))
            ],
          )
        ],
      ),
    );
  }

  void sendMessage(String message, {bool isMeSender = true}) {
    MessageModel newMessage = MessageModel(
        id: uuid.v4(),
        message: message,
        createdAt: DateTime.now(),
        isMeSender: isMeSender);

    // Because we're using reverse - true on animated list
    messages.insert(0, newMessage);

    animatedListKey.currentState!.insertItem(0);
  }
}

class MessageModel {
  final String id;
  final String message;
  final DateTime createdAt;
  final bool isMeSender;

  MessageModel({
    required this.id,
    required this.message,
    required this.createdAt,
    this.isMeSender = true,
  });
}
