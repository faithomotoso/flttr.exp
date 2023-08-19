import 'package:flttr_exp/ui/pages/animated_list_exmp.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel messageModel;

  // Animation from animated list builder
  final Animation<double> animation;

  const MessageWidget(
      {super.key, required this.messageModel, required this.animation});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(color: messageModel.isMeSender ? Colors.black : Colors.white);

    return SlideTransition(
      position: animation.drive(
          Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0))
              .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn))),
      child: Align(
        alignment: messageModel.isMeSender
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: BoxDecoration(
              color: messageModel.isMeSender
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.blueAccent,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageModel.message,
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                messageModel.createdAt.toLocal().toString(),
                style: textStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
