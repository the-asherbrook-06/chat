// packages
import 'package:chat/components/ProfilePictureURL.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;

  void searchUsers() async {
    final searchText = _searchController.text.trim().toLowerCase();
    if (searchText.isEmpty) return;

    setState(() => _isLoading = true);

    final query = await FirebaseFirestore.instance.collection('users').get();
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final filtered = query.docs
        .where((doc) {
          final email = doc['email'].toString().toLowerCase();
          final username = doc['name'].toString().toLowerCase();
          return (email.contains(searchText) || username.contains(searchText)) &&
              doc.id != currentUserId;
        })
        .map((doc) {
          return {
            'id': doc.id,
            'email': doc['email'],
            'username': doc['name'],
            'profilePic': doc['profilePic'],
          };
        })
        .toList();

    setState(() {
      _results = filtered;
      _isLoading = false;
    });
  }

  Future<void> startChat(String targetUserId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final members = [currentUser.uid, targetUserId]..sort();
    final chatId = members.join('_');

    final chatDoc = FirebaseFirestore.instance.collection('chatRooms').doc(chatId);

    await chatDoc.set({
      'type': '1-1',
      'members': members,
      'lastMessage': null,
    }, SetOptions(merge: true));

    Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
    Navigator.pushNamed(context, '/chatRoom', arguments: chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
        ),
        title: Text("New Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SearchBar(
              autoFocus: true,
              controller: _searchController,
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              hintText: "Search",
              trailing: [IconButton(icon: Icon(Icons.search), onPressed: searchUsers)],
              onSubmitted: (_) => searchUsers(),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (_results.isEmpty)
              Text("No results", style: Theme.of(context).textTheme.bodyMedium)
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final user = _results[index];
                    return ListTile(
                      leading: ProfilePictureURL(URL: user['profilePic'], radius: 28),
                      title: Text(user['username']),
                      subtitle: Text(user['email']),
                      trailing: Icon(Icons.chat),
                      onTap: () => startChat(user['id']),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
