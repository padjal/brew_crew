import 'package:brewcrew/Services/auth.dart';
import 'package:brewcrew/Shared/constants.dart';
import 'package:brewcrew/Shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            onPressed: (){
              widget.toggleView();
              //switch screen
            },
          ),
        ],
      ),
      backgroundColor: Colors.brown[100],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty?'Enter an email':null,
                onChanged: (val){
                  setState(() => email=val
                );
              }),
              SizedBox(height: 20.0,),
              TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val) => val.length<6?'Enter a longer password':null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password=val
                  );
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                    'Resgister',
                    style: TextStyle(
                      color: Colors.white,
                    )
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()) {
                    setState(()=>loading=true);
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      loading = false;
                      setState(() => error = 'Supply a valid email');
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0)
              )
            ],
          ),
        ),
      ),
    );
  }
}
