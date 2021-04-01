import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/widgets/footer.dart';
import 'package:chat_app/src/screens/widgets/header.dart';
import 'package:chat_app/src/screens/widgets/subtitle.dart';
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
      body: Padding(
        padding: EdgeInsets.only(top: 24),
        child: Container(
          height: queryData.size.height,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
                SubTitleWidget(
                  isSignUp: false,
                ),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: queryData.size.width * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintText: "Email адрес",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintText: "Пароль",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
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
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
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
                        print("Height: " + queryData.size.height.toString());
                        print('LoginData');
                        //print('UserName: ' + username.text);
                        print('Email: ' + email.text);
                        print('Password: ' + password.text);
                        // Navigator.pushReplacement(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             );
                      }
                    },
                    child: Text(
                      "Зарегистрироваться",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontSize: 18.0,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.width * 0.15,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FooterTextWidget(
                    isSignUp: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
