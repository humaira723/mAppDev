// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:fanpage_app/models/user.dart';
import 'package:fanpage_app/screens/wrapper.dart';
import 'package:fanpage_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(), //wrapper is home screen
      ),
    );
  }
}
