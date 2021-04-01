import 'package:chat_app/src/screens/chatrooms/chatrooms.dart';
import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/widgets/footer.dart';
import 'package:chat_app/src/screens/widgets/header.dart';
import 'package:chat_app/src/screens/widgets/subtitle.dart';
import 'package:chat_app/src/services/auth/auth.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthFb _authService = new AuthFb();
  AddUser _addUser = new AddUser();
  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  _createUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await _authService
          .signUp(email: email.text, password: password.text)
          .then((result) async {
        if (result != null) {
          Map<String, String> userData = {
            "userName": username.text,
            "userEmail": email.text,
            "timeStamp": Timestamp.now().seconds.toString(),
            "userId": AccountPrefs.getUserIdSharedPreference();
          };
          _addUser.add(userData);
          AccountPrefs.saveUserEmailSharedPreference(email.text);
          AccountPrefs.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRooms()));
        }
      });
    }
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
                        print('RegisterData');
                        print('UserName: ' + username.text);
                        print('Email: ' + email.text);
                        print('Password: ' + password.text);
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
