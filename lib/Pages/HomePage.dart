import 'package:flutter/material.dart';
import 'package:c/Services/Auth/auth_services.dart';
import 'package:c/Services/Chat/Chat_Service.dart';
import 'package:c/Components/my_Drawer.dart';
import 'package:c/Components/User_tile.dart';
import 'Chat_Page.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("H O M E"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatServices.getUserStreamExcludingBlocked(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Users Found"));
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildListItem(Map<String, dynamic> userData, BuildContext context) {
    final currentuser = _authServices.getCurrentUser();
    if (currentuser == null) {
      return const Text("You are not logged in");
    }
    final username = userData["name"] as String? ?? 'Unknown';
    final useremail = userData["email"] as String? ?? 'Unknown';
    final userId = userData["uid"] as String? ?? '';
    if (useremail != currentuser.email) {
      return UserTile(
        emailtext: useremail,
        text: username.toString(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiveremail: username,
                receiverID: userId,
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
