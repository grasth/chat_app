import 'package:chat_app/src/screens/auth/auth.dart';
import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:chat_app/src/screens/register/register.dart';
import 'package:flutter/material.dart';

class FooterTextWidget extends StatelessWidget {
  final bool isSignUp;

  const FooterTextWidget({this.isSignUp});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      child: Column(
        children: [
          Text(
            isSignUp ? "У вас уже есть аккаунт?" : "У вас нет аккаунта?",
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
                                isSignUp ? new SignUpPage() : new AuthPage()))
                  },
              child: Text(isSignUp ? "Войти" : "Зарегистрироваться",
                  style: authHelpTextstyle))
        ],
      ),
    );
  }
}
