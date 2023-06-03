import 'package:final_bim494_project/pages/widget/header_widget.dart';
import 'package:flutter/material.dart';

import '../common/theme_util.dart';
import 'login_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool _isButtonClicked = false;

  void _handleButtonClick() {
    setState(() {
      _isButtonClicked = !_isButtonClicked;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = _isButtonClicked
        ? ThemeUtil.fourthColor : ThemeUtil.thirdColor;
    double _headerHeight = 120;

    return Material(
      child: Container(
        color: ThemeUtil.whiteColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              // adjust the top position based on header height
              top: _headerHeight,
              left: MediaQuery.of(context).size.width / 120,
              right: MediaQuery.of(context).size.width / 120,
              child: Image.asset("assets/app_logo.png"),
            ),
            Container(
              height: _headerHeight,
              // let's make a common header widget
              child: HeaderWidget(_headerHeight, false, Icons.login_rounded),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.66,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                    color: ThemeUtil.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Track your meds,",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mogra-Regular',
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: ThemeUtil.secondaryColor,
                      ),
                    ),
                    Text(
                      "health manifest!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mogra-Regular',
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: ThemeUtil.secondaryColor,
                      ),
                    ),
                    SizedBox(height: 60,),
                    Material(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: _handleButtonClick,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 80,
                          ),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              color: ThemeUtil.whiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

