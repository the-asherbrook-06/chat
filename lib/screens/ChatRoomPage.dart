// packages
import 'package:chat/components/TypingIndicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// components
import '../components/ProfilePictureURL.dart';

class ChatRoomPage extends StatefulWidget {
  final String chatRoomId;
  const ChatRoomPage({super.key, required this.chatRoomId});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String profilePicureURL = "";
  String otherUserId = "";
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  @override
  void dispose() {
    setTyping(false);
    _messageController.dispose();
    super.dispose();
  }

  Future<void> fetchUserDetails() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final chatDoc = await FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomId)
        .get();

    if (chatDoc.exists && chatDoc.data()?['members'] != null) {
      final List members = chatDoc.data()!['members'];
      setState(() {
        otherUserId = members.firstWhere((id) => id != currentUser.uid);
      });

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(otherUserId).get();

      if (userDoc.exists) {
        setState(() {
          profilePicureURL = userDoc.data()?['profilePic'] ?? '';
          username = userDoc.data()?['name'] ?? '';
          email = userDoc.data()?['email'] ?? '';
        });
      }
    }
  }

  Future<void> sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    setTyping(false);

    final currentUser = FirebaseAuth.instance.currentUser!;
    final timestamp = FieldValue.serverTimestamp();
    final messageDoc = FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomId)
        .collection('messages')
        .doc();

    await messageDoc.set({'senderId': currentUser.uid, 'text': message, 'timestamp': timestamp});
    await FirebaseFirestore.instance.collection('chatRooms').doc(widget.chatRoomId).update({
      'lastMessage': {'text': message, 'timestamp': timestamp, 'senderId': currentUser.uid},
    });

    _messageController.clear();
  }

  void setTyping(bool isTyping) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomId)
        .collection('typing')
        .doc(currentUser.uid)
        .set({'isTyping': isTyping});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            ProfilePictureURL(type: "chat", URL: profilePicureURL, radius: 24),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username.isNotEmpty ? username : "Loading...",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(email, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            icon: Icon(HugeIcons.strokeRoundedMoreVertical),
            onSelected: (value) {
              // TODO: Add Menu functionality
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(HugeIcons.strokeRoundedPen01),
                    SizedBox(width: 12),
                    Text("Edit Chat"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clean',
                child: Row(
                  children: [
                    Icon(HugeIcons.strokeRoundedClean),
                    SizedBox(width: 12),
                    Text("Clean History"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedDelete01,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 12),
                    Text("Delete Chat"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .doc(widget.chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet."));
                }

                final currentUserId = FirebaseAuth.instance.currentUser!.uid;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                    );
                  }
                });

                return ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final isMe = data['senderId'] == currentUserId;
                    final text = data['text'] ?? '';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // TODO: Add Read Recipts
                        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          if (otherUserId.isNotEmpty)
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .doc(widget.chatRoomId)
                  .collection('typing')
                  .doc(otherUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final isTyping = data['isTyping'] ?? false;
                  if (isTyping) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TypingIndicator(),
                        ),
                      ),
                    );
                  }
                }
                return SizedBox.shrink();
              },
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SafeArea(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => sendMessage(),
                textInputAction: TextInputAction.send,
                onChanged: (val) {
                  setTyping(val.isNotEmpty);
                },
                onEditingComplete: () => setTyping(false),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  suffixIcon: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(HugeIcons.strokeRoundedSent02),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
