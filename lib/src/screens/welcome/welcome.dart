import 'package:chat_app/src/screens/auth/auth.dart';
import 'package:chat_app/src/screens/components/bazaar_text.dart';
import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:chat_app/src/screens/register/register.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Container(
      color: backGroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: queryData.size.height * 0.06),
          ),
          BazaarText(),
          new Image.asset('./lib/src/assets/image/startUp.png',
              width: queryData.size.width * 0.6,
              height: queryData.size.width * 0.6),
          Text(
            "Присоединяйтесь к нам",
            style: welcomeTextStyle28,
          ),
          Padding(
            padding: EdgeInsets.only(top: queryData.size.height * 0.02),
          ),
          Text(
            "в место, в котором удобно общаться\nс друзьями",
            textAlign: TextAlign.center,
            style: welcomeTextStyle18_gray,
          ),
          Padding(
            padding: EdgeInsets.only(top: queryData.size.height * 0.06),
          ),
          FlatButton(
            onPressed: () => {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new SignUpPage()))
            },
            color: blueColor,
            minWidth: queryData.size.width * 0.45,
            height: queryData.size.width * 0.15,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            child: Text(
              "Начать",
              style: welcomeTextStyle18_white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: queryData.size.height * 0.06),
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
                            builder: (BuildContext context) => new AuthPage()))
                  },
              child: Text("Войти", style: authHelpTextstyle))
        ],
      ),
    );
  }
}
