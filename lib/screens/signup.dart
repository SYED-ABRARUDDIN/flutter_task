import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newstask/models/constants/colors.dart';
import 'package:newstask/models/constants/customalert.dart';
import 'package:newstask/models/constants/customfield.dart';
import 'package:newstask/models/constants/myfonts.dart';
import 'package:newstask/screens/homescreen.dart';
import 'package:newstask/screens/login.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();
  var name_controller = TextEditingController();
  
  FirebaseAuth _auth = FirebaseAuth.instance;
 final formkey = GlobalKey<FormState>();

  

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
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.9,
        //   child: Custom_Field(
        //       controller: name_controller,
        //       labelText: "Name",
        //       hintText: "Enter Your Name",
        //       isreadonly: false,
        //       showstar: false,
        //       isnumber: false),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
                 Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Custom_Field(
            controller: name_controller,
            labelText: "Name",
            hintText: "Enter Your Name",
            isreadonly: false,
            showstar: false,
            isnumber: false,
            validate: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please Enter Name";
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
            controller: email_controller,
            labelText: "Email",
            hintText: "Enter Email Address",
            isreadonly: false,
            showstar: false,
            isnumber: false,
            validate: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please Enter Email Address";
              } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value.trim())) {
        return "Email is Invalid";
        }
           
              
              else {
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
                } else if(value.trim().length<8){
                  return "Password is too short";
                }
                else {
                  null;
                }
              }),
        ),
        SizedBox(height: 20),
        getVerifyBtn("SignUp"),
        SizedBox(height: 10),
        Text("-- OR --"),
          SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login_Screen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have an Account?",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: AppFonts.regular,
                  )),
              Text(
                "Login",
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
          register(email_controller.text, password_controller.text,name_controller.text);
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.bluecolor),

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

  message(error, context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlert("${error.code}", Colors.red, "SignUp Error");
        });
  }

  register(email, password,name) async {
    try {
      var user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        createuserToFirebase(email,name);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {}
    } catch (e) {
      message(e, context);
    }
  }

   createuserToFirebase(emailid,name) async {
    try {
      var createddate= DateTime.now();
      var temp_data = {
        "id": emailid,
        "name":name,
        "createdDate":createddate
      };
      var dr =
          await FirebaseFirestore.instance.collection("users").doc("$emailid");
      dr.set(temp_data).then((value) {
        print("sucess");
      });
    } catch (e) {
      print(e);
    }
   }
}
