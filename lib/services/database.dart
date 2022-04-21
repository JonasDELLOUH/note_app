import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:note_app/model/member.dart';

class DatabaseService {
  Future<MemberModel> createMember(String name, String key) async {
    MemberModel _memberModel = MemberModel();
    await FirebaseFirestore.instance
        .collection("Member")
        .doc(key)
        .set({"memberUid": key, "memberName": name}).catchError((e) {
      print("Member non ajouté : ");
      print(e);
    });
    return _memberModel;
  }

  Future<void> addNote(
      Map<String, dynamic> noteData, String memberKey) async {
    try{
      await FirebaseFirestore.instance
          .collection("Members")
          .doc(memberKey)
          .collection("Notes")
          .doc()
          .set(noteData);
    } catch(e){
      if (kDebugMode) {
        print("Note non ajouté : ${e.toString()}");
      }

    }
  }
}
