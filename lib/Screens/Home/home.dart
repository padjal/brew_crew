import 'package:brewcrew/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/Services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(onPressed: ()async{
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('logout'))
        ],
      ),
      backgroundColor: Colors.brown[50],
    );
  }
}
