import 'package:flutter/material.dart';
import 'package:fanpage_app/services/auth.dart';

class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);
  final Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // identifies form

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
        title: Text('Join the FanPage'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign In',
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
                    'Sign Up',
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // valid when null is received
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'Invalid email.');
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
