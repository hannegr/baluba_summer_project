/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static const LoginPageName = '/loginpage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _createUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: _createUser,
          child: Text("Create New Account"),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  static const SignUpPageName = '/signuppage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "Juliannereere@hotmail.no", password: "123456");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: _createUser,
          child: Text("Register new account"),
        ),
      ),
    );
  }
}
