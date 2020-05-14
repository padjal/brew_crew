import 'package:brewcrew/Models/brew.dart';
import 'package:brewcrew/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/Screens/Home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
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
        body: BrewList(),
        backgroundColor: Colors.brown[50],
      ),
    );
  }
}
