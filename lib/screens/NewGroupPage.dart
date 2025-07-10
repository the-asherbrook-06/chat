// packages
import 'package:chat/components/ProfilePictureURL.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _selectedUsers = [];
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

  Future<void> createGroup() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final memberIds = [currentUser.uid, ..._selectedUsers.map((u) => u['id'])]..sort();

    final chatDoc = FirebaseFirestore.instance.collection('chatRooms').doc();
    final chatId = chatDoc.id;

    await chatDoc.set({
      'type': 'group',
      'members': memberIds,
      'lastMessage': null,
      'nickname': '',
      'groupPic': '',
    });

    Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
    Navigator.pushNamed(context, '/groupRoom', arguments: chatId);
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
        title: Text("New Group"),
      ),
      floatingActionButton: _selectedUsers.length >= 2
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              onPressed: createGroup,
              icon: Icon(HugeIcons.strokeRoundedSent02),
              label: Text("Create Group"),
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
            if (_selectedUsers.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Wrap(
                  spacing: 6,
                  runSpacing: -8,
                  children: _selectedUsers.map((user) {
                    return Chip(
                      label: Text(user['username']),
                      avatar: ProfilePictureURL(
                        type: 'chat',
                        URL: user['profilePic'] ?? '',
                        radius: 14,
                      ),
                      // avatar: CircleAvatar(backgroundImage: NetworkImage(user['profilePic'] ?? '')),
                      onDeleted: () {
                        setState(() {
                          _selectedUsers.removeWhere((u) => u['id'] == user['id']);
                        });
                      },
                    );
                  }).toList(),
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
                        final alreadySelected = _selectedUsers.any((u) => u['id'] == user['id']);
                        setState(() {
                          if (alreadySelected) {
                            _selectedUsers.removeWhere((u) => u['id'] == user['id']);
                          } else {
                            _selectedUsers.add(user);
                          }
                        });
                      },
                      selected: _selectedUsers.any((u) => u['id'] == user['id']),
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
