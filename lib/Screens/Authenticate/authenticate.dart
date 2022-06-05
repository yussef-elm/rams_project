import 'package:flutter/material.dart';
import 'package:rams_project/Screens/Authenticate/register.dart';
import 'package:rams_project/Screens/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context){
    if(showSignIn){
      return SignIn();
    }else {
      return Register();
    }
  }
}

