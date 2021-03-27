import 'package:chat_app/src/screens/auth/auth.dart';
import 'package:chat_app/src/screens/components/bazaar_text.dart';
import 'package:chat_app/src/screens/components/signUpForm.dart';
import 'package:chat_app/src/screens/components/welcome_text.dart';
import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: backGroundColor,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.04),
              ),
              BazaarText(),
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.04),
              ),
              WelcomeText(),
              SignUpText(),
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.02),
              ),
              SignUpForm(),
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.04),
              ),
              Text(
                "У вас уже есть аккаунт?",
                textAlign: TextAlign.center,
                style: welcomeTextStyle18_gray,
              ),
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.01),
              ),
              GestureDetector(
                  onTap: () => {
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new AuthPage()))
                      },
                  child: Text("Войти", style: authHelpTextstyle))
            ]))));
  }
}
