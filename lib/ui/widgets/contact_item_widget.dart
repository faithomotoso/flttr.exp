import 'package:cached_network_image/cached_network_image.dart';
import 'package:flttr_exp/core/models/contacts.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              imageUrl: contact.imageUrl,
              fit: BoxFit.cover,
              placeholder: (ctx, _) => const SizedBox(width: 60,),
            )),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              contact.email,
              style: const TextStyle(color: Colors.black26),
            )
          ],
        ))
      ],
    );
  }
}
