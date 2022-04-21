import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/sign_up.dart';
import 'package:note_app/widgets/widgets.dart';

import '../model/member.dart';
import '../services/auth.dart';
import '../services/database.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  late String email, password;
  bool _isLoading = false;

  final authInstance = FirebaseAuth.instance;

  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();
  MemberModel memberModel = MemberModel();

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          setState(() {
            memberModel.memberUid = value.user!.uid;
            memberModel.memberEmail = value.user!.email!;
            _isLoading = false;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          memberKey: memberModel.memberUid,
                        )));
          });
        });
      } catch (e) {
        if (kDebugMode) {
          print("Erreur : ${e.toString()}");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty
                            ? "Veuillez entrer votre mail"
                            : null;
                      },
                      decoration: const InputDecoration(hintText: "Email"),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val!.isEmpty
                            ? "Veuillez entrer votre mot de passe"
                            : null;
                      },
                      decoration:
                          const InputDecoration(hintText: "Mot de passe"),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child:
                          blueButton(context: context, label: "Se Connecter"),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Vous n'avez pas de compte?  ",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text("S'inscrire",
                                style: TextStyle(
                                    fontSize: 15.5,
                                    decoration: TextDecoration.underline)))
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
