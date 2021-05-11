import 'package:chat_app/src/screens/chatrooms/chatrooms.dart';
import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/widgets/footer.dart';
import 'package:chat_app/src/screens/widgets/header.dart';
import 'package:chat_app/src/screens/widgets/subtitle.dart';
import 'package:chat_app/src/services/auth/auth.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthFb _authService = new AuthFb();
  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  _showToast() {
    Fluttertoast.showToast(
        msg: "Ошибка регистрации, попробуйте другую почту",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  _createUser() async {
    if (_formKey.currentState.validate()) {
      _authService
          .signUp(
              username: username.text.replaceAll(" ", "").trim(),
              email: email.text,
              password: password.text)
          .then((result) {
        if (result != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRooms()));
        } else
          _showToast();
      });
    }
  }

  Future<bool> checkName(name) async {
    return await FirestoreFunctions().searchByName(name);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
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
                  isSignUp: true,
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
                          controller: username,
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintText: "Username",
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
                            if (value.trim().contains(" ")) {
                              return 'Имя пользователя не может содержать пробелы';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 13,
                        ),
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
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return 'Введите корректную почту';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 13,
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
                            if (value.length < 6) {
                              return 'Введите корректный пароль';
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
                        _createUser();
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
                    isSignUp: true,
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
