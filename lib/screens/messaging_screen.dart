// screens/messaging_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/message.dart';

class MessagingScreen extends StatefulWidget {
  final String userId;

  MessagingScreen({required this.userId});

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  List<Message> messages = []; // Populate this list with messages from Firestore or another database
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index].content),
                  subtitle: Text('Sent by ${messages[index].senderId} on ${messages[index].timestamp}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(labelText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send the message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
