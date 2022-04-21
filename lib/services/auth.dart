import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:note_app/model/member.dart';


class AuthService {
  // Auth
  final authInstance = FirebaseAuth.instance;

  //Connexion
  Future signInWithEmailAndPassword(String mail, String pwd) async {
    MemberModel member = MemberModel();
    try {
      await authInstance
          .signInWithEmailAndPassword(email: mail, password: pwd)
          .then((value) {
        member.memberUid = value.user!.uid;
        member.memberEmail = value.user!.email!;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Erreur : ${e.toString()}");
      }
    }
    return member;
  }

  Future signUpWithEmailAndPassword(
      String email, String password) async {
    MemberModel member = MemberModel();
    try {
      await authInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        member.memberUid = value.user!.uid;
        member.memberEmail = value.user!.email!;

      });
    } catch (e) {
      if (kDebugMode) {
        print("Erreur : ${e.toString()}");
      }
    }
    return member;
  }

  Future signOut() async {
    try {
      return await authInstance.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await authInstance.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
