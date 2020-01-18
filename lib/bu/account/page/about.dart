import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Text(
              "Gank.io",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              color: Color(0xffe5e5e5),
              width: MediaQuery.of(context).size.width,
              height: 1,
            ),
            Text("技术干货"),
            GestureDetector(
              child: Text(
                "http://gank.io",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
