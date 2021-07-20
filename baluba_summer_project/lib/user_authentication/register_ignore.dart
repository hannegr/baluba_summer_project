// registrere ny bruker ved hjelp av e-mail og passord
/*
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView }); // la på required

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null, // la på utropstegn https://fileidea.com/2021/05/05/method-cant-be-unconditionally-invoked-because-the-receiver-can-be-null-with-firestore/
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null, // la på utropstegn https://fileidea.com/2021/05/05/method-cant-be-unconditionally-invoked-because-the-receiver-can-be-null-with-firestore/
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white), 
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){ // la på utropstegn https://fileidea.com/2021/05/05/method-cant-be-unconditionally-invoked-because-the-receiver-can-be-null-with-firestore/
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
*/