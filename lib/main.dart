import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_project/app_route.dart';
import 'mobx/counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mobx Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Mobx Demo'),
      routes: AppRoute.routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Text(
          'You have pushed the button this many times:',
        ),
            Observer(
              builder: (_) => Text(
                'count is ${MyApp.counter.value}',
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
            SizedBox(height: 100),
            RaisedButton(
              child: Text('加'),
              onPressed: MyApp.counter.increment,
            ),
            RaisedButton(
              child: Text('减'),
              onPressed: MyApp.counter.increment,
            ),
            RaisedButton(
                child: Text('go to second page'),
                onPressed: () => Navigator.pushNamed(context, '/second')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //counter.set(0);
        },
        tooltip: '归零',
        child: Text('归零'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
