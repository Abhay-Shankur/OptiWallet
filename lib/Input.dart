import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: 'Enter ID',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Download data from Firestore and save to local storage
                downloadDataAndSaveToLocal(context);
              },
              child: Text('Download and Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadDataAndSaveToLocal(BuildContext context) async {
    // Get the entered ID
    String enteredID = _idController.text.trim();

    // Check if ID is provided
    if (enteredID.isEmpty) {
      // Show an error message if the ID is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a valid ID.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Fetch data from Firestore based on ID
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('Credentials').doc(enteredID).get();

    // Check if the document exists
    if (snapshot.exists) {
      // Convert the retrieved data to a Map
      Map<String, dynamic> firestoreData = snapshot.data() as Map<String, dynamic>;

      // Convert data to JSON string
      String jsonData = jsonEncode(firestoreData);

      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      String localPath = appDocumentsDirectory.path;
      // Specify the local storage path where the data will be saved
      // String localPath = 'your_local_path'; // Change this to your desired local path

      // Save JSON data to local storage
      await saveDataToLocalPath(jsonData, localPath);

      // Show success message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Data downloaded and saved to local storage successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Show an error message if the document does not exist
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No document found with the provided ID.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> saveDataToLocalPath(String jsonData, String path) async {
    final file = File('$path/data.json');

    // Write data to file
    await file.writeAsString(jsonData);
  }
}
