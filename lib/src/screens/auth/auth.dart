import 'package:chat_app/src/screens/components/bazaar_text.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
            SizedBox(height: 10),
            SignUpText(),
            Padding(
              padding: EdgeInsets.only(top: queryData.size.height * 0.02),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите корректные данные';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите корректные данные';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: queryData.size.width - 40,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(blueColor)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print('LoginData');
                    print('Email: ' + email.text);
                    print('Password: ' + password.text);
                  }
                },
                child: Text(
                  "Войти",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontSize: 18.0,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
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
