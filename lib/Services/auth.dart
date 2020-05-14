import 'package:brewcrew/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewcrew/Models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on Firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null? User(uid: user.uid):null;
  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user)=>_userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }
  //create a method to sigh in anon
Future signInAnon() async{
  try{
    final AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }
  catch(e) {
    print(e.toString());
    return null;
  }
}
  //sign  in email and pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('o', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}