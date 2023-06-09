import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../style/styles.dart';
import '../pages.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 240;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                // let's make a common header widget
                child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
              ),
              SafeArea(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      // This will be the login form
                      child: Column(
                        children: [
                          Text(
                            'Hello',
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              fontFamily: 'Mogra-Regular',
                              color: ThemeUtil.thirdColor,
                            ),
                          ),
                          Text(
                            'Sign-in into your account',
                            style: TextStyle(color: ThemeUtil.whiteColor),
                          ),
                          SizedBox(height: 30.0),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextField(
                                      decoration:
                                      ThemeHelper().textInputDecoration(
                                          'User Name',
                                          'Enter your user name'),
                                    ),
                                    decoration:
                                    ThemeHelper().inputBoxDecorationShadow(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    child: TextField(
                                      obscureText: true,
                                      decoration:
                                      ThemeHelper().textInputDecoration(
                                          'Password', 'Enter your password'),
                                    ),
                                    decoration:
                                    ThemeHelper().inputBoxDecorationShadow(),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute( builder: (context) =>
                                              ForgotPasswordPage()), );
                                      },
                                      child: Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                          color: ThemeUtil.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ArchivoNarrow-Medium',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: ThemeHelper().buttonStyle(),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Text(
                                          'Sign In'.toUpperCase(),
                                          style: TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ArchivoNarrow-Medium',
                                              color: Colors.white),),
                                      ),
                                      onPressed: (){
                                        //After successful login we will redirect to profile page.
                                        // Let's make profile page now
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage()));

                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10,20,10,20),
                                    //child: Text('Don\'t have an account? Make one'),
                                    child: Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: "Don\'t have an account? ",
                                              style: TextStyle(
                                                  fontFamily: 'ArchivoNarrow-Medium',
                                              fontSize: 15)),
                                              TextSpan(
                                                text: 'Make one',
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = (){
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegistrationPage()));
                                                  },
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'ArchivoNarrow-Medium',
                                                    color: ThemeUtil.secondaryColor,
                                                  fontSize: 15,),
                                              ),
                                            ]
                                        )),
                                  ),
                                ],
                              )),
                        ],
                      ))),
            ],
          )),
    );

  }
}