import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/screens/sign_in.dart';

import 'helpers/helper_functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedin = false;
  late String memberUid;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value) {
      _isLoggedin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SignIn(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
