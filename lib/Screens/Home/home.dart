import 'package:flutter/material.dart';
import 'package:rams_project/Services/auth.dart';

import '../../constants.dart';

class Home extends StatelessWidget{
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text('Welcome to RAMS'),
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.SignOut();
              },
              icon: const Icon(Icons.logout, color: Colors.white,),
              label: Text(
                "Logout",
                style: TextStyle(color: Colors.white, ),
              ),
          )
        ],
      ),
    );
  }
}

