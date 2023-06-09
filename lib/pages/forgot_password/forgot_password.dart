import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../style/styles.dart';
import '../pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isButtonClicked = false;

  void _handleButtonClick() {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
      if(_formKey.currentState!.validate()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ForgotPasswordVerificationPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    Color buttonColor = _isButtonClicked
        ? ThemeUtil.fourthColor : ThemeUtil.thirdColor;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight, true, Icons.password_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Forgot Password?',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: ThemeUtil.thirdColor,
                                fontFamily: 'Mogra-Regular',
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.0),
                            Text('We will email you a verification code to check your authenticity.',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'ArchivoNarrow-Medium',
                                fontSize: 15,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    "Email",
                                    "Enter your email"),
                                validator: (val) {
                                  if(val!.isEmpty) {
                                    return "Email can't be empty";
                                  }
                                  else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShadow(),
                            ),
                            SizedBox(height: 70.0),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      40, 10, 40, 10),
                                  child: Text(
                                    "Send".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ArchivoNarrow-Medium',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _handleButtonClick();},
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Remember your password? "),
                                  TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginPage()),
                                        );
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      color: ThemeUtil.secondaryColor,
                                      fontFamily: 'ArchivoNarrow-Medium',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}