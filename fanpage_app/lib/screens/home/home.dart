import 'package:fanpage_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Fan Page'),
        backgroundColor: Colors.green[300],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
