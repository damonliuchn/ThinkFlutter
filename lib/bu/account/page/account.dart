import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/event/theme_color_event.dart';
import 'package:gank_flutter/ui/icons/iconfont.dart';
import 'package:gank_flutter/util/common_util.dart';
import 'package:gank_flutter/ui/color.dart';
import 'package:gank_flutter/util/log_util.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff5f5f5),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xffe5e5e5)))),
            child: Row(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(left: 30, top: 50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset("images/flutter.png"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 30, top: 50),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Test",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Test Flutter",
                                      style:
                                          TextStyle(color: Color(0xff666666)),
                                    ),
                                  ),
                                  Icon(
                                    IconFont.iconright,
                                    color: Color(0xff666666),
                                    size: 15,
                                  ),
                                  Container(
                                    width: 15,
                                    height: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/about");
//              Navigator.push(context, MaterialPageRoute(builder: (context) => (About())));
            },
            child: Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Color(0xffe5e5e5)),
                      bottom: BorderSide(color: Color(0xffe5e5e5)))),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 20, 10, 20),
                    child: Icon(
                      IconFont.iconabout,
                      color: AppColor.primarySwatch,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "关于",
                      style: TextStyle(
                        color: Color(0xff1a1a1a),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Icon(
                    IconFont.iconright,
                    color: Color(0xff666666),
                    size: 18,
                  ),
                  Container(
                    width: 15,
                    height: 0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
