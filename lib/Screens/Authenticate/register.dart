import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rams_project/Screens/Authenticate/sign_in.dart';
import 'package:rams_project/Screens/Authenticate/social_icon.dart';

import '../../Helpers/already_have_an_account_acheck.dart';
import '../../Helpers/rounded_button.dart';
import '../../Helpers/rounded_input_field.dart';
import '../../Helpers/rounded_password_field.dart';
import '../../Services/auth.dart';
import '../../constants.dart';
import '../Home/home.dart';
import 'or_divider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 90,horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "SIGNUP",
                  style: TextStyle(color : kPrimaryColor, fontWeight: FontWeight.bold,fontSize: 20.0),
                ),
                SizedBox(height: size.height * 0.03),
                /*SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),*/
                Image.asset(
                  "assets/images/register.png",
                  height: size.height * 0.25,
                ),
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
                  text: "SIGNUP",
                  press: () async{
                    if(_formKey.currentState!.validate()){
                      dynamic result = await _auth.RegisterWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Siging up failed! Please enter the right credentials!';
                        });
                      }
                     // Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account ? ",
                      style: TextStyle(color: kPrimaryColor, ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignIn();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Sign In" ,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
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
