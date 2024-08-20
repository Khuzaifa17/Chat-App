import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String emailtext;
  final void Function()? onTap;
  const UserTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.emailtext});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text(text),
            subtitle: Text(emailtext),
            leading: Icon(Icons.person),
          )
          // Row(
          //   children: [
          //     Icon(Icons.person),
          //     Text(text),
          //   ],
          // ),
          ),
    );
  }
}
