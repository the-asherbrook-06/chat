// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

// models
import 'package:chat/models/RoomModel.dart';

// components
import 'package:chat/components/ProfilePictureURL.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({super.key});

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  final _searchController = TextEditingController();
  String _searchTerm = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final theme = (View.of(context).platformDispatcher.platformBrightness == Brightness.light)
        ? "light"
        : "dark";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SearchBar(
            controller: _searchController,
            hintText: "Search chats",
            elevation: const WidgetStatePropertyAll(1),
            trailing: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chatRooms')
                .where('members', arrayContains: currentUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(child: CircularProgressIndicator());

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    SvgPicture.asset("assets/$theme/begin_chat.svg", width: 220),
                    const SizedBox(height: 24),
                    Text("All quiet... for now", style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text(
                      "Start a chat to see messages here",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                );
              }

              final allChats = snapshot.data!.docs
                  .map((doc) => Room.fromMap(doc.id, doc.data() as Map<String, dynamic>))
                  .where(
                    (chat) => _searchTerm.isEmpty || chat.id.toLowerCase().contains(_searchTerm),
                  )
                  .toList();

              return ListView.builder(
                itemCount: allChats.length,
                itemBuilder: (context, index) {
                  final chat = allChats[index];
                  final otherUserIds = chat.members.where((id) => id != currentUserId).toList();

                  return FutureBuilder<List<DocumentSnapshot>>(
                    future: Future.wait(
                      otherUserIds.map(
                        (id) => FirebaseFirestore.instance.collection('users').doc(id).get(),
                      ),
                    ),
                    builder: (context, userSnapshot) {
                      if (!userSnapshot.hasData) return SizedBox.shrink();

                      final userDocs = userSnapshot.data!;
                      final memberNames = userDocs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return data['name'] ?? data['email'] ?? 'Unknown';
                      }).toList();

                      final displayName = chat.nickname.isNotEmpty
                          ? chat.nickname
                          : memberNames.join(', ');

                      return ListTile(
                        // TODO: change custom group profile url
                        leading: ProfilePictureURL(
                          type: chat.type,
                          URL: (userDocs.first.data() as Map<String, dynamic>)['profilePic'],
                          radius: 28,
                        ),
                        title: Text(displayName),
                        subtitle: Text(
                          chat.lastMessageText ?? "New Chat",
                          style: TextStyle(
                            fontStyle: chat.lastMessageText == null
                                ? FontStyle.italic
                                : FontStyle.normal,
                            color: chat.lastMessageText == null
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        onLongPress: () {
                          log("Long Pressed");
                        },
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(HugeIcons.strokeRoundedMoreVertical),
                        ),
                        onTap: () {
                          switch (chat.type) {
                            case 'chat':
                              Navigator.pushNamed(context, '/chatRoom', arguments: chat.id);
                              break;
                            case 'group':
                              Navigator.pushNamed(context, '/groupRoom', arguments: chat.id);
                              break;
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
