import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/register/imageUpload.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

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
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      return value.trim().isEmpty
                          ? 'Username is required'
                          : false;
                    }),
                const SizedBox(height: 5.0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _agreedToTOS,
                        onChanged: _setAgreedToTOS,
                      ),
                      GestureDetector(
                        onTap: () => _setAgreedToTOS(!_agreedToTOS),
                        child: const Text(
                          'согласие обработки Персональных данных',
                        ),
                      ),
                    ],
                  ),
                ),
                // OutlineButton(
                //   highlightedBorderColor: Colors.black,
                //   onPressed: _submittable() ? _submit : null,
                //   child: const Text('Register'),
                //   color: blueColor,
                // ),
                FlatButton(
                  onPressed: //_submittable()
                      //     ? _submit
                      //     :
                      () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ImageUpload()))
                  },
                  color: blueColor,
                  minWidth: queryData.size.width,
                  height: queryData.size.width * 0.12,
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
              ],
            )));
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
