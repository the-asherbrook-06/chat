// packages
import 'package:svg_flutter/svg_flutter.dart';
import 'package:flutter/material.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({super.key});

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  // TODO: Update _chats variable
  final List _chats = [];

  @override
  Widget build(BuildContext context) {
    final theme = (View.of(context).platformDispatcher.platformBrightness == Brightness.light)
        ? "light"
        : "dark";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SearchBar(
            elevation: WidgetStatePropertyAll(1),
            hintText: "Search",
            leading: Icon(Icons.search),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        Expanded(
          child: _chats.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: SizedBox()),
                    SvgPicture.asset("assets/$theme/begin_chat.svg", width: 220),
                    SizedBox(height: 24),
                    Text("All quiet... for now", style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: 4),
                    Text(
                      "Start a chat to see messages here",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Expanded(child: SizedBox()),
                  ],
                )
              : ListView.builder(
                  itemCount: _chats.length,
                  itemBuilder: (context, index) {
                    final chat = _chats[index];
                    return ListTile(title: Text(chat.name), subtitle: Text(chat.lastMessage));
                  },
                ),
        ),
      ],
    );
  }
}
