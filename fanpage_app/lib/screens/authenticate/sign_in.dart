import 'package:fanpage_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  final Function toggleView; // constructor for the WIDGET not stateobject
  SignIn({required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identifies form

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        elevation: 0.0,
        title: Text('Sign in to FanPage'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an email.' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                    // gets value from form field
                    // USERNAME
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true, // hides password
                  validator: (val) => val!.length < 5
                      ? 'Password must be more than 5 characters.'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }, // PASSWORD
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.lightGreen[100],
                  child: Text(
                    'Sign In',
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'Invalid account.');
                      }
                    }
                  }, // async task to interact w firebase as it takes some time
                ),
              ],
            ),
          )),
    );
  }
}
