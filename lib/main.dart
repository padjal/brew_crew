import 'package:brewcrew/Models/user.dart';
import 'package:brewcrew/Screens/Home/home.dart';
import 'package:brewcrew/Screens/wrapper.dart';
import 'package:brewcrew/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/Models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

