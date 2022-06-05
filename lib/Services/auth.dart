import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user.dart';

class AuthService{
  final FirebaseAuth _auth =  FirebaseAuth.instance;
  // créer un user à partir de FirebaseUser
  CustomUser? _userFromFirebaseUser(User? user){
    return user != null ? CustomUser(uid : user.uid) : null;
  }

  // auth change User Stream
  Stream<CustomUser?> get user{
    return _auth.authStateChanges()
    //  .map((User? user) => (user != null) ? CustomUser(uid : user.uid) : null);
    .map(_userFromFirebaseUser);
  }

  // sign in anonyme
  Future SignInAnonymously() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user =  result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in email/password
  Future SignInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // register Email/password
  Future RegisterWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //sign out
  Future SignOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print('Signing out failed with error : '+ e.toString());
    }
  }
}