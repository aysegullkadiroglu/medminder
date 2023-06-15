import 'package:final_bim494_project/pages/medicine_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../commons/theme_util.dart';
import '../pages/widget/header_widget.dart';

class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ]
              )
          ) ,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 5,
                          color: ThemeUtil.whiteColor),
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
                      size: 80,
                      color: Colors.grey.shade300,),
                  ),
                  SizedBox(height: 30,),
                  Text('Ayşe Kaya',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mogra-Regular',
                        color: ThemeUtil.fifthColor),),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8.0,
                              bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Center(
                            child: Text(
                              "User Information",
                              style: TextStyle(
                                color: ThemeUtil.thirdColor,
                                fontSize: 22.5,
                                fontFamily: 'ArchivoNarrow-Medium',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text('Name Surname',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'ArchivoNarrow-Medium',
                              ),),
                            trailing: Text('Ayşe Kaya',
                              style: TextStyle(color: Colors.grey,
                                  fontSize: 17),),
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text('Age',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'ArchivoNarrow-Medium',
                              ),),
                            trailing: Text('15',
                              style: TextStyle(color: Colors.grey,
                                  fontSize: 17),),
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text('Gender',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'ArchivoNarrow-Medium',
                              ),),
                            trailing: Text('Woman',
                            style: TextStyle(color: Colors.grey,
                            fontSize: 17),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}