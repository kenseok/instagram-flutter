import 'package:flutter/material.dart';
import 'package:instagram_kenseok_app/widgets/sign_in_form.dart';
import 'package:instagram_kenseok_app/widgets/sign_up_form.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  Widget currentWiget = SigninForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
            children: <Widget>[
              AnimatedSwitcher(duration: Duration(milliseconds: 300),
                  child: currentWiget),
              _goToSignUpPageBtn(context),
            ],
          )),
    );
  }

  Positioned _goToSignUpPageBtn(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 40,
      child: FlatButton(
        shape: Border(top: BorderSide(color: Colors.grey[300])),
        onPressed: () {
          setState(() {
            if(currentWiget is SigninForm){
              currentWiget = SignUpForm();
            }else{
              currentWiget = SigninForm();
            }
          });
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(style: const TextStyle(), children: <TextSpan>[
            TextSpan(
                text: (currentWiget is SigninForm)? 'Don`t have an account?':'Already have an account?',
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.black54)),
            TextSpan(
                text: (currentWiget is SigninForm)? 'Sign Up':'Sign In',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue[600])),
          ]),
        ),
      ),
    );
  }
}
