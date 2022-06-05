import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rams_project/Screens/Authenticate/register.dart';
import 'package:rams_project/Services/auth.dart';
import 'package:rams_project/constants.dart';

import '../../Helpers/already_have_an_account_acheck.dart';
import '../../Helpers/rounded_button.dart';
import '../../Helpers/rounded_input_field.dart';
import '../../Helpers/rounded_password_field.dart';
import 'background.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey();
  // textfields states:
  String email ='';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 90,horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "LOGIN",
                  style: TextStyle(color : kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: size.height * 0.03),
               /* SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),*/
                Image.asset(
                  "assets/images/help.png",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                  validator: (value)=> value!.isEmpty ? 'Please enter an e-mail address' : null,
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },// onChange
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "E-mail address"),
                ),
                TextFormField(
                  validator: (value)=> value!.length<6 ? 'Password must be 6+ digits long' : null,
                  obscureText: true,
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },// onChange
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Password"),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    if(_formKey.currentState!.validate()){
                      dynamic result = await _auth.SignInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Siging in failed! Please retry later!';
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an Account ? ",
                      style: TextStyle(color: kPrimaryColor, ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Register();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up" ,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
