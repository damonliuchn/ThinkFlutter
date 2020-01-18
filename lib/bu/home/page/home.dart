import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/bu/home/widget/article_list.dart';
import 'package:gank_flutter/event/theme_color_event.dart';
import 'package:gank_flutter/util/common_util.dart';
import 'package:gank_flutter/util/log_util.dart';
import 'package:gank_flutter/util/toast_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _tabList = ["App", "前端", "Android", "iOS"];
  TabController _tabController;

  var _colorSubscription;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: _tabList.length, vsync: this);

    //测试eventbus
    _colorSubscription = CommonUtil.EVENTBUS.on<ThemeColorEvent>().listen((event) {
      LogUtil.log("Color:" + event.colorStr);
      ToastUtil.show("Color:" + event.colorStr);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    //取消订阅
    _colorSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabList.length,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: Center(
                child: Text(
                  "干货集中营",
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: false,
                onTap: _onTabBarTap,
                tabs: _tabList.map((item) {
                  return Tab(text: item);
                }).toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: _tabList.map((item) {
                return Center(
                  child: ArticleList(item),
                );
              }).toList(),
            )));
  }

  void _onTabBarTap(int value) {}
}
