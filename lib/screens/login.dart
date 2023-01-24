import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newstask/models/constants/colors.dart';
import 'package:newstask/models/constants/customalert.dart';
import 'package:newstask/models/constants/customfield.dart';
import 'package:newstask/models/constants/myfonts.dart';
import 'package:newstask/screens/homescreen.dart';
import 'package:newstask/screens/signup.dart';
class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();
 
  FirebaseAuth _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();

 
  message(error, context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
       
           return CustomAlert("${error.code}", Colors.red, "Login Error");
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: SafeArea(
                child: Form(
          key: formkey,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(child: getLogInWidget()),
            ),
          ),
        ))));
  }

  Widget getLogInWidget() {
    var loginWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
             Image.asset('images/appicon.png', height: 100, fit: BoxFit.fill),

       SizedBox(width: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "News",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 25,
              fontFamily: AppFonts.medium,
              // fontWeight: FontWeight.bold
            ),
          ),
          Text("App",
              style: TextStyle(
                color: AppColors.bluecolor,
                fontSize: 25,
                fontFamily: AppFonts.large,
                //  fontWeight: FontWeight.bold
              )),
        ]),
        SizedBox(
          height: 20,
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Custom_Field(
            controller: email_controller,
            labelText: "Email",
            hintText: "Enter Email Address",
            isreadonly: false,
            showstar: false,
            isnumber: false,
            validate: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please Enter Email Address";
              } else {
                null;
              }
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Custom_Field(
              controller: password_controller,
              labelText: "Password",
              hintText: "Enter Password Here",
              isreadonly: false,
              showstar: true,
              isnumber: false,
              validate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please Enter Password";
                } else {
                  null;
                }
              }),
        ),
        SizedBox(height: 20),
        getVerifyBtn("Login"),
        SizedBox(height: 10),
        Text("-- OR --"),
      
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignUp_Screen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont Have an Account?",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: AppFonts.regular,
                  )),
              Text(
                "Signup",
                style: TextStyle(
                  color: AppColors.bluecolor,
                  fontSize: 16,
                  fontFamily: AppFonts.large,
                  //  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
      ],
    );
    return loginWidget;
  }

  Widget getVerifyBtn(String title) {
    var btn = ElevatedButton(
      onPressed: () {
        if (formkey.currentState!.validate()) {
          loginwithcredentials(email_controller.text, password_controller.text);
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0170d0)),

      // Color.fromRGBO(36, 182, 174, 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  color: Colors.white, fontFamily: AppFonts.regular, fontSize: 16)),
        ],
      ),
    );
    return btn;
  }

  loginwithcredentials(_email, _password) async {
    try {
      var user = (await _auth.signInWithEmailAndPassword(
              email: _email, password: _password))
          .user;
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {}
    } catch (e) {
      message(e, context);
    }
  }

  }
