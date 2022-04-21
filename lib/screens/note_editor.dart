import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/services/database.dart';
import 'package:note_app/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  final String memberKey;

  const NoteEditorScreen({Key? key, required this.memberKey}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Note Title"),
              style: AppStyle.mainTitleStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: AppStyle.dateTitleStyle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Note Content"),
              style: AppStyle.mainTitleStyle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        child: const Icon(Icons.save),
        onPressed: () async {

          databaseService.addNote({
            "color_id": color_id,
            "creation_date": date,
            "note_content": _mainController.text,
            "note_title": _titleController.text
          }, widget.memberKey);
          Navigator.pop(context);
        },
      ),
    );
  }
}
