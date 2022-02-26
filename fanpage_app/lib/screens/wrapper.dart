import 'package:fanpage_app/models/user.dart';
import 'package:fanpage_app/screens/authenticate/authenitcate.dart';
import 'package:fanpage_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //return either home or authenticate
    if (user == null) {
      //no user
      return Authenticate();
    } else {
      return Home();
    }
  }
}
