import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/bu/account/page/about.dart';
import 'package:gank_flutter/bu/account/page/account.dart';
import 'package:gank_flutter/bu/account/page/upload_image.dart';
import 'package:gank_flutter/bu/home/api/home_api.dart';
import 'package:gank_flutter/bu/home/page/home.dart';
import 'package:gank_flutter/engine/http_manager.dart';
import 'package:gank_flutter/model/http_result.dart';
import 'package:gank_flutter/ui/iconfont.dart';
import 'package:gank_flutter/util/common_util.dart';
import 'package:gank_flutter/ui/color.dart';
import 'package:gank_flutter/util/host_util.dart';
import 'package:gank_flutter/util/log_util.dart';
import 'package:gank_flutter/util/sp_manager.dart';
import 'package:gank_flutter/util/toast_util.dart';
import 'package:pkg_network/pkg_network.dart';
//import 'package:plugin_dialog/plugin_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:event_bus/event_bus.dart';

void main() {
  asyncMain();
}

void asyncMain() async {
  WidgetsFlutterBinding  flutterBinding = WidgetsFlutterBinding.ensureInitialized();
  //异步方法初始化
  await SpUtil.open();
  //同步方法初始化
  int pkgResult = Calculator().addOne(1);
  LogUtil.log("testPackageDev:" + pkgResult.toString());
  HostUtil.setSystemUIOverlayStyle();
  testDialogPlugin();
  //页面初始化
  flutterBinding.scheduleAttachRootWidget(MyApp());
  flutterBinding.scheduleWarmUpFrame();
}

void testDialogPlugin() async {
  //String platformVersion = await PluginDialog.platformVersion;
  //LogUtil.log("testPluginDev:" + platformVersion);
}

class MyApp extends StatelessWidget {
  //全局变量
  static BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    return BotToastInit(
        child: MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: "/",
      theme: ThemeData(
          primarySwatch: AppColor.primarySwatch, primaryColor: Colors.white),
      //设置App主题
      routes: {"/": (context) => MyHomePage(), "/about": (context) => About(),"/upload": (context) => UploadImage()},
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var _pageController = PageController(initialPage: 0);

  void _incrementCounter() {
    ToastUtil.show("DDDDDDD");
    HttpResult httpResult = HttpResult.fromJson({"error":true});
//    httpResult.

    SpUtil.setObject("httpResult", httpResult);

    HttpResult bb = SpUtil.getObject("httpResult",$HttpResultFromJson);


    ToastUtil.show("DDDDDDD"+bb.error.toString());

//    setState(() {
//      _selectedIndex++;
//    });
//    if (!HostUtil.isWeb()) {
//      testCompute();
//    }

//    HttpManager.polling(
//        () {
//          return HomeApi().getTasks("App", "1");
//        },
//        true,
//        5,
//        10000,
//        (results) {
//          return false;
//        },
//        (result) {},
//        () {
//          ToastUtil.show("failure");
//        });
  }

  void testCompute() async {
    //todo  compute 目前测试不支持 web
    int _count = await compute(countEven, 1000000000);
    ToastUtil.show("DDDDDDD" + _count.toString());
  }

  static int countEven(int num) {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_pageController.hasClients) {
//      _pageController.animateToPage(_selectedIndex,
//          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      _pageController.jumpToPage(_selectedIndex);
    }
  }

  void _onPageChange(int index) {
    print("_onPageChange");
    setState(() {
      _selectedIndex = index;
    });

//    HomeApi().getTasks("all", "1").then((httpArticle) => {
//          LogUtil.log(
//              "ddddddddddddddddddd" + httpArticle.results.elementAt(0).desc)
//        });
  }

  StatefulWidget _getPageByIndex(int index) {
    switch (index) {
      case 1:
        return AccountPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    MyApp.buildContext = context;
    HttpResult bb = SpUtil.getObject("httpResult",$HttpResultFromJson);
    ToastUtil.show("DDDDDDD"+bb.error.toString());
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return Center(
            child: _getPageByIndex(index), //每个页面展示的组件
          );
        },
        itemCount: 2,
        //页面数量
        onPageChanged: _onPageChange,
        //页面切换
        controller: _pageController,
        //控制器
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: new Icon(IconFont.iconhome), title: new Text("首页")),
          BottomNavigationBarItem(
              icon: new Icon(IconFont.iconaccount), title: new Text("我的")),
        ],
        selectedItemColor: AppColor.primarySwatch,
        unselectedItemColor: Color(0xff666666),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedFontSize: 12.0,
      ),
    );
  }
}
