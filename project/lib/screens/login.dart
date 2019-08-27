import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: <Widget>[
            Container(
              height: height * .4,
              width: width,
              padding: EdgeInsets.only(
                  top: height * .1, left: width * .1, right: width * .1),
              decoration: BoxDecoration(
                  //color: Colors.red,
                  image:
                      DecorationImage(image: AssetImage("assets/check.png"))),
            ),
            SizedBox(
              height: height * .05,
            ),
            Container(
              height: height * .35,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * .1),
              //color: Colors.green,
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * .07,
                    width: width * .8,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: width * .05),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(1, 1))
                        ]),
                    child: TextField(
                      decoration:
                          InputDecoration.collapsed(hintText: 'Identifier'),
                      controller: usernameController,
                    ),
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  Container(
                    height: height * .07,
                    width: width * .8,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: width * .05),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(1, 1))
                        ]),
                    child: TextField(
                      decoration:
                          InputDecoration.collapsed(hintText: 'Password'),
                      controller: usernameController,
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: height * .08,
                        width: width * .45,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.4,
                                  0.6,
                                  0.9
                                ],
                                colors: [
                                  Color(0xFFB2FFA9),
                                  Color(0xFFA0E8AF),
                                  Color(0xFF95D4A2),  
                                  Color(0xFF3DE28E),
                                  
                                ]),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green,
                                  blurRadius: 2,
                                  offset: Offset(2, 2)),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
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
