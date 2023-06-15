import 'package:final_bim494_project/commons/theme_util.dart';
import 'package:final_bim494_project/json/suggestion_json.dart';
import 'package:final_bim494_project/main.dart';
import 'package:flutter/material.dart';

import '../pages/widget/header_widget.dart';

class MedicineSuggestionPage extends StatefulWidget {
  const MedicineSuggestionPage({Key? key}) : super(key: key);

  @override
  _MedicineSuggestionPageState createState() =>
      _MedicineSuggestionPageState();
}

class _MedicineSuggestionPageState
    extends State<MedicineSuggestionPage> {

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 200;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight, true, Icons.lightbulb_outline),
            ),
            Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(
                children: List.generate(
                    suggestions.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: suggestions[index]['color'],
                          borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 3,
                                // changes position of shadow
                              ),
                            ]
                         ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25,
                              bottom: 25, top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(suggestions[index]['title'],
                              style: TextStyle(
                                fontFamily: 'ArchivoNarrow-Medium',
                                fontSize: 20.0,
                                color: ThemeUtil.fifthColor
                              ),),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                suggestions[index]['text'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: ThemeUtil.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign:TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

