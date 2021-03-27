import 'package:chat_app/src/screens/components/bazaar_text.dart';
import 'package:chat_app/src/screens/components/signInForm.dart';
import 'package:chat_app/src/screens/components/welcome_text.dart';
import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:chat_app/src/screens/register/register.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
              padding: EdgeInsets.only(top: queryData.size.height * 0.1),
            ),
            WelcomeText(),
            SignUpText(),
            Padding(
              padding: EdgeInsets.only(top: queryData.size.height * 0.1),
            ),
            SignInForm(),
            Padding(
              padding: EdgeInsets.only(top: queryData.size.height * 0.1),
            ),
            Text(
              "У вас нет аккаунта?",
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
                                  new SignUpPage()))
                    },
                child: Text("Зарегистрироваться", style: authHelpTextstyle)),
          ]),
        ),
      ),
    );
  }
}
