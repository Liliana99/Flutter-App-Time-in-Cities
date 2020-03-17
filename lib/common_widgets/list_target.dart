
import 'package:clima/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

const _info = "Press the button  🏢 ";
const _info2 = 'to search the city.';

class ListTarget  {
   ListTarget({this.keyButton});
  var keyButton = GlobalKey();

  
 Future<List> initTargets() async {
    List<TargetFocus> targets = List();
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                        fontSize: 30.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                     
                      children: <Widget>[
                        SizedBox(height: 20,),
                        CustomText(
                          data: _info,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.justify,
                          color: Colors.yellowAccent,
                          fontSize: 26.0,
                        ),
                         CustomText(
                                data: _info2,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                                color: Colors.yellowAccent,
                                fontSize: 26.0,
                              ),
                       
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return targets;
  }

}
