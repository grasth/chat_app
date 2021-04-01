import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  final bool isSignUp;

  const SubTitleWidget({this.isSignUp});

  @override
  Widget build(BuildContext context) {
    return Text(
      (isSignUp ? "Зарегистрируйтесь" : "Авторизуйтесь") +
          ", что бы\nначать пользоваться\nприложением",
      style: welcomeTextStyle18_gray,
      textAlign: TextAlign.center,
    );
  }
}
