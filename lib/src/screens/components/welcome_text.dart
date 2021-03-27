import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Добро пожаловать",
      style: welcomeTextStyle28,
    );
  }
}

class SignUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Зарегистрируйтесь, что бы\nначать пользоваться\nприложением",
      style: welcomeTextStyle18_gray,
      textAlign: TextAlign.center,
    );
  }
}
