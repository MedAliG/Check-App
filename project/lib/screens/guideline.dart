import 'package:flutter/material.dart';
import 'package:Check/addons/dotsIndicator.dart';
import 'package:Check/objects/guideItems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideLines extends StatefulWidget {
  _GuideLinesState createState() => _GuideLinesState();
}

class _GuideLinesState extends State<GuideLines> {
  SharedPreferences prefs;
  final _controller = PageController();
  int _currentPage = 0;
  bool last = false;
  bool changed = false;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  static final Item x = Item(
      id: 1,
      title: "Title",
      details: "Lorem ipsum dolor sit amet, consetetur",
      image: "assets/pic1.png");
  static final Item r = Item(
      id: 2,
      title: "Title",
      details: "Lorem ipsum dolor sit amet, consetetur",
      image: "assets/pic2.png");
  static final Item s = Item(
      id: 3,
      title: "Title",
      details: "Lorem ipsum dolor sit amet, consetetur",
      image: "assets/pic3.png");
  List<Item> list = [x, r, s];
  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.topRight,
                //height: height * .1,
                child: Image(
                  height: height * .2,
                  image: AssetImage("assets/top_rev.png"),
                ),
              ),
              Container(
                height: height,
                alignment: Alignment.bottomLeft,
                //height: height * .1,
                child: Image(
                  height: height * .3,
                  image: AssetImage("assets/btm_rev.png"),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    //padding: EdgeInsets.only(top: height * .15, bottom: height * .1),
                    child: Container(
                      height: height * .9,
                      width: width,
                      child: PageView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        onPageChanged: _onPageViewChange,
                        itemBuilder: (BuildContext context, int index) {
                          //_changingState();
                          return _singleGuide(list[index]);
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        //color: Colors.red,
                        width: width * .7,
                        height: height * .05,
                        alignment: Alignment.centerRight,
                        child: Container(
                          //color: Colors.blue,
                          width: width * .35,
                          child: DotsIndicator(
                            controller: _controller,
                            color: Colors.black,
                            itemCount: list.length,
                            onPageSelected: (int page) {
                              _controller.animateToPage(
                                page,
                                duration: _kDuration,
                                curve: _kCurve,
                              );
                            },
                          ),
                        ),
                      ),
                      _btmRightBtn(),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPageViewChange(int page) {
    print("Current Page: " + page.toString());
    if (page == list.length - 1) {
      setState(() {
        last = true;
      });
      print(list.length);
      print(last);
    } else {
      setState(() {
        last = false;
      });
      print(list.length);
      print(last);
    }
  }

  _btmRightBtn() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (last) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/home", (Route<dynamic> route) => false);
        },
        child: Container(
          height: height * .05,
          width: width * .3,
          child: Center(
            child: Text(
              "Start",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Lexend",
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _controller.nextPage(
            duration: _kDuration,
            curve: _kCurve,
          );
        },
        child: Container(
          height: height * .05,
          width: width * .3,
          child: Center(
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Lexend",
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      );
    }
  }

  _singleGuide(Item x) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(20),
      width: width * .5,
      //color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * .15),
            child: Image(
              image: AssetImage(x.image),
            ),
          ),
          SizedBox(
            height: height * .1,
          ),
          Container(
            child: Text(
              x.title,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontFamily: "LivvicBold"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * .02),
            child: Text(x.details,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54, fontFamily: "Livvic", fontSize: 20)),
          ),
          SizedBox(
            height: height * .1,
          )
        ],
      ),
    );
  }

  _initData() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool("firstVisit", false);
  }
}
