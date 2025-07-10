// packages
import 'package:chat/components/TypingIndicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// components
import '../components/ProfilePictureURL.dart';

class GroupRoomPage extends StatefulWidget {
  final String chatRoomId;
  const GroupRoomPage({super.key, required this.chatRoomId});

  @override
  State<GroupRoomPage> createState() => _GroupRoomPageState();
}

class _GroupRoomPageState extends State<GroupRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, String> _userNameCache = {};
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
      final data = chatDoc.data()!;
      final List members = data['members'];
      final String? nickname = data['nickname'];

      List<String> usernames = [];

      for (final id in members) {
        if (id == currentUser.uid) continue;
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(id).get();
        if (userDoc.exists) {
          if (otherUserId.isEmpty) {
            profilePicureURL = userDoc.data()?['profilePic'] ?? '';
            otherUserId = id;
          }
          usernames.add(userDoc.data()?['name'] ?? '');
        }
      }

      setState(() {
        username = (nickname != null && nickname.isNotEmpty) ? nickname : usernames.join(', ');
        email = '';
      });
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

  Future<String> getSenderName(String uid) async {
    if (_userNameCache.containsKey(uid)) {
      return _userNameCache[uid]!;
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final name = userDoc.data()?['name'] ?? 'Unknown';
    _userNameCache[uid] = name;
    return name;
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
            // TODO: change custom group profile url
            ProfilePictureURL(type: "group", URL: profilePicureURL, radius: 24),
            SizedBox(width: 12),
            Text(
              username.isNotEmpty ? username : "Loading...",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(HugeIcons.strokeRoundedMoreVertical))],
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
                  // inside ListView children:
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final senderId = data['senderId'];
                    final text = data['text'] ?? '';
                    final isMe = senderId == currentUserId;

                    final previousSenderId = index > 0
                        ? (snapshot.data!.docs[index - 1].data()
                              as Map<String, dynamic>)['senderId']
                        : null;

                    final showHeader = !isMe && senderId != previousSenderId;

                    return FutureBuilder<String>(
                      future: getSenderName(senderId),
                      builder: (context, nameSnapshot) {
                        final senderName = nameSnapshot.connectionState == ConnectionState.done
                            ? nameSnapshot.data ?? 'Unknown'
                            : '';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (!isMe && showHeader) ...[
                                FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(senderId)
                                      .get(),
                                  builder: (context, userSnapshot) {
                                    final profilePicUrl = userSnapshot.data?.data() != null
                                        ? (userSnapshot.data!.data()
                                                  as Map<String, dynamic>)['profilePic'] ??
                                              ''
                                        : '';

                                    return ProfilePictureURL(
                                      type: 'user',
                                      URL: profilePicUrl,
                                      radius: 16,
                                    );
                                  },
                                ),
                                SizedBox(width: 8),
                              ] else if (!isMe) ...[
                                SizedBox(
                                  width: 40,
                                ),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    if (showHeader && senderName.isNotEmpty && !isMe)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          senderName,
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? Theme.of(context).colorScheme.primaryContainer
                                            : Theme.of(context).colorScheme.secondaryContainer,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        text,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
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
