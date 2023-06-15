import 'package:final_bim494_project/models/gender.dart';
import 'package:final_bim494_project/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../commons/theme_helper.dart';
import '../commons/theme_util.dart';
import '../pages/widget/header_widget.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late  Future<void> registerUser;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  bool checkedValue = false;
  bool checkboxValue = false;
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtil.whiteColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 5,
                                    color: ThemeUtil.whiteColor,
                                  ),
                                  color: ThemeUtil.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: ThemeHelper().textInputDecoration(
                              'Name Surname',
                              'Enter your first name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: ThemeHelper().textInputDecoration(
                              'Email',
                              'Enter your email',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _ageController,
                            decoration: ThemeHelper().textInputDecoration(
                              "Age",
                              "Enter your age",
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your age";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: DropdownButtonFormField<Gender>(
                            decoration: ThemeHelper().textInputDecoration(
                              "Gender",
                              "Select your gender",
                            ),
                            value: selectedGender,
                            items: [
                              DropdownMenuItem(
                                value: Gender.FEMALE,
                                child: Text('Female'),
                              ),
                              DropdownMenuItem(
                                value: Gender.MALE,
                                child: Text('Male'),
                              ),
                              DropdownMenuItem(
                                value: Gender.OTHER,
                                child: Text('Other'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please select your gender";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                              "Password",
                              "Enter your password",
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                              "Re-enter password",
                              "Enter your password again",
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password again";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShadow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Transform.scale(
                                      scale: 1.2,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          checkboxTheme: CheckboxThemeData(
                                            fillColor: MaterialStateColor.resolveWith(
                                                  (states) {
                                                if (states.contains(MaterialState.selected)) {
                                                  return ThemeUtil.fourthColor;
                                                }
                                                return ThemeUtil.fourthColor;
                                              },
                                            ),
                                          ),
                                        ),
                                        child: Checkbox(
                                          value: checkboxValue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = value!;
                                              state.didChange(value);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(
                                        color: ThemeUtil.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.error,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Kayıt işlemini burada gerçekleştirin
                                // _nameController.text kullanıcı adını,
                                // _emailController.text e-posta adresini,
                                // _passwordController.text şifreyi,
                                // _ageController.text yaş bilgisini,
                                // selectedGender cinsiyeti içerir.
                                registerUser;

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ),
                                      (Route<dynamic> route) => false,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}