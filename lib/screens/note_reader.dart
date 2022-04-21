import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  const NoteReaderScreen({Key? key, required this.doc}) : super(key: key);

  @override
  _NoteReaderScreenState createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        title: const Text("Note", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitleStyle,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"].toString(),
              style: AppStyle.dateTitleStyle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContentStyle,
            ),
          ],
        ),
      ),
    );
  }
}
