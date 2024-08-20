import 'package:c/Services/Chat/Chat_Service.dart';
import 'package:c/Themes/Theme_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  final String messageId;
  final String userId;
  ChatBubble(
      {super.key,
      required this.iscurrentuser,
      required this.message,
      required this.messageId,
      required this.userId});

  void showoption(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("Report"),
              onTap: () {
                _reportMessage(context, messageId, userId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text("Block"),
              onTap: () {
                _blockUser(context, userId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text("Cancel"),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkmode;
    return GestureDetector(
      onLongPress: () {
        if (!iscurrentuser) {
          showoption(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: iscurrentuser
                ? (isDarkMode ? Colors.blue.shade600 : Colors.grey.shade500)
                : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
              color: iscurrentuser
                  ? Colors.white
                  : isDarkMode
                      ? Colors.white
                      : Colors.black),
        ),
      ),
    );
  }

  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report Message"),
        content: const Text("Do you want to report this message"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                ChatServices().reportuser(messageId, userId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Message Reported Successfully")));
              },
              child: const Text("Report")),
        ],
      ),
    );
  }

  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Block User"),
        content: const Text("Do you want to Block this User"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                ChatServices().blockUser(userId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User Blocked Successfully")));
              },
              child: const Text("Block")),
        ],
      ),
    );
  }
}
