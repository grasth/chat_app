import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/const/font_const.dart';
import 'package:flutter/material.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          alignment: Alignment.center,
          color: backGroundColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.06),
              ),
              Text(
                "Приветствуем, Jack Snow.\nВы успешно зарегистрировались",
                style: welcomeTextStyle24,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.1),
              ),
              Text(
                "Выберите фотографию профиля",
                style: textStyle20,
                textAlign: TextAlign.center,
              ),
              new Image.asset('./lib/src/assets/image/Upload.png',
                  width: queryData.size.width * 0.7,
                  height: queryData.size.width * 0.7),
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
                minWidth: queryData.size.width * 0.9,
                height: queryData.size.width * 0.12,
                child: Text(
                  "Загрузить изображение",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontSize: 18.0,
                      decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: queryData.size.height * 0.1),
              ),
              Text(
                "Пропустить",
                style: welcomeTextStyle18_gray,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
