import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 7.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      return value.trim().isEmpty ? 'Email is required' : false;
                    }),
                const SizedBox(height: 5.0),
                TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      return value.trim().isEmpty
                          ? 'Password is required'
                          : false;
                    }),
                const SizedBox(height: 20.0),
                FlatButton(
                  onPressed: () => {},
                  color: blueColor,
                  minWidth: queryData.size.width,
                  height: queryData.size.width * 0.12,
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
              ],
            )));
  }
}
