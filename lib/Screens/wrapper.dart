import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rams_project/Screens/Authenticate/authenticate.dart';
import 'package:rams_project/Models/user.dart';

import 'Home/home.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final user = Provider.of<CustomUser?>(context);

    if(user == null){
      print('toAuth');
      return Authenticate();
    }else {
      print('toHome');
      print(user.uid);
      return Home();
    }

  }
}