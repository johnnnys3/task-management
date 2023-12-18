import 'package:flutter/material.dart';

class CollaborationScreen extends StatefulWidget {
  @override
  _CollaborationScreenState createState() => _CollaborationScreenState();
}

class _CollaborationScreenState extends State<CollaborationScreen> {
  List<String> collaborators = ['User1', 'User2', 'User3']; // Replace with actual collaborators

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collaboration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Collaborators',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: collaborators.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(collaborators[index]),
                    // Add additional collaboration information or actions here
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showAddCollaboratorDialog();
              },
              child: Text('Add Collaborator'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddCollaboratorDialog() async {
    String newCollaborator = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Collaborator'),
          content: TextField(
            onChanged: (value) {
              newCollaborator = value;
            },
            decoration: InputDecoration(labelText: 'Collaborator Email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the new collaborator
                setState(() {
                  collaborators.add(newCollaborator);
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
