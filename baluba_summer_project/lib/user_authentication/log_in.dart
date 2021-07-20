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
import 'package:profile_page_test/user_authentication/sign_up.dart';
import 'package:profile_page_test/profile/make_profile_page.dart';

class LoginPage extends StatefulWidget {
  static const LoginPageName = '/loginpage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;
  String error = '';
  final auth = FirebaseAuth.instance;

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _goToSignUpPage(context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        setState(() => error = 'Wrong password provided');
      }
    }
  }

  void _goToSignUpPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      SignUpPage.SignUpPageName,
      //arguments: { kanskje senere
      //},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hællibælluuu'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'E-post'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Passord'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
                child: Text('Logg inn'),
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _email, password: _password);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('Bruker ikke registrert.');
                      setState(() => error = 'Bruker ikke registrert');
                      //_goToSignUpPage(context);
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      setState(() => error = 'Feil passord');
                    }
                  }
                  auth
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((_) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  });
                  //auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfilePage()));
                  //});
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
              child: Text('Ny bruker'),
              onPressed: () {
                auth
                    .createUserWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                });
              },
            )
          ]),
          SizedBox(height: 12.0),
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          ),
        ],
      ),
      /*
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
          child: Text("Log in"),
        ),
      ),
    */
    );
  }
}
