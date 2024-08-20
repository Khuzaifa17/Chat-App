import 'package:c/Components/User_tile.dart';
import 'package:c/Services/Auth/auth_services.dart';
import 'package:c/Services/Chat/Chat_Service.dart';
import 'package:flutter/material.dart';

class Blockeduser extends StatelessWidget {
  Blockeduser({super.key});

  final ChatServices chatservice = ChatServices();
  final AuthServices authServices = AuthServices();

  void _showUnblockbox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unblocked User"),
        content: const Text("Are you Sure you want to unblock this User"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                chatservice.unBlockedUser(userId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("User Unblocked Successfully")));
              },
              child: const Text("Unblocked")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userId = authServices.getCurrentUser()!.uid;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BLOCKED USER"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatservice.getBlockedUserStream(userId),
        builder: (context, snapshot) {
          print('Fetching blocked users for userId: $userId');
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle null or empty data
          final blockeduser = snapshot.data ?? [];
          print('Blocked users: $blockeduser'); // Debug print to check data

          if (blockeduser.isEmpty) {
            return const Center(child: Text("No Blocked Users"));
          }

          return ListView.builder(
            itemCount: blockeduser.length,
            itemBuilder: (context, index) {
              final user = blockeduser[index];
              return UserTile(
                text: user['name'],
                onTap: () => _showUnblockbox(context, user['uid']),
                emailtext: user['email'],
              );
            },
          );
        },
      ),
    );
  }
}
