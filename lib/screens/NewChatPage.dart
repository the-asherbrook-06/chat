// packages
import 'package:chat/components/ProfilePictureURL.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  Map<String, dynamic>? _selectedUser;
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

  Future<void> startChat() async {
    if (_selectedUser == null) return;
    final currentUser = FirebaseAuth.instance.currentUser!;
    final members = [currentUser.uid, _selectedUser!['id']]..sort();

    final chatDoc = FirebaseFirestore.instance.collection('chatRooms').doc();
    final chatId = chatDoc.id;

    await chatDoc.set({'type': 'chat', 'members': members, 'lastMessage': null, 'nickname': ''});

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
      floatingActionButton: _selectedUser != null
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              onPressed: startChat,
              icon: Icon(HugeIcons.strokeRoundedSent02),
              label: Text("Start Chat"),
            )
          : null,
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
            if (_selectedUser != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Chip(
                  label: Text(_selectedUser!['username']),
                  avatar: ProfilePictureURL(
                    type: 'chat',
                    URL: _selectedUser!['profilePic'] ?? '',
                    radius: 14,
                  ),
                  onDeleted: () {
                    setState(() {
                      _selectedUser = null;
                    });
                  },
                ),
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
                      leading: ProfilePictureURL(type: "chat", URL: user['profilePic'], radius: 28),
                      title: Text(user['username']),
                      subtitle: Text(user['email']),
                      trailing: Icon(HugeIcons.strokeRoundedComment01),
                      onTap: () {
                        setState(() {
                          _selectedUser = user; // Replace the selected user
                        });
                      },
                      selected: _selectedUser?['id'] == user['id'],
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
