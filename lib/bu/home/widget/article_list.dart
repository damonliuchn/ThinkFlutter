import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/bu/home/api/home_api.dart';
import 'package:gank_flutter/bu/home/model/article.dart';
import 'package:gank_flutter/bu/home/widget/article_item.dart';
import 'package:gank_flutter/engine/http_manager.dart';
import 'package:gank_flutter/util/log_util.dart';

class ArticleList extends StatefulWidget {
  final String category;

  ArticleList(this.category);

  @override
  _ArticleListState createState() {
    return _ArticleListState();
  }
}

class _ArticleListState extends State<ArticleList>
    with AutomaticKeepAliveClientMixin {
  List<Article> _dataList = [];
  ScrollController _scrollController;
  int _load = 0;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var px = _scrollController.position.pixels;
      if (px == _scrollController.position.maxScrollExtent) {
        LogUtil.log("加载更多！");
        _onLoadMore();
      }
    });
    _initData(_page);
  }

  Future<void> _initData(int page) async {
    //var newList = (await HomeApi().getTasks(widget.category, page.toString())).results;
    HttpManager.request([HomeApi().getTasks("App", page.toString())],true,(results){
      var newList = (results[0] as HttpArticle).results;
      setState(() {
        if (page == 1) {
          _dataList.clear();
        }
        _dataList.addAll(newList);
        if (newList == null || newList.length == 0) {
          _load = 3;
        }else{
          _load = 0;
        }
        _page = ++page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return ArticleItem(_dataList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  color: Color(0xffe5e5e5),
                );
              },
              itemCount: _dataList.length,
            ),
          ),
        ),
        Offstage(
          offstage: _load != 2,
          child: Center(
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                        width: 14,
                        height: 14,
                      ),
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                  Expanded(
                    child: Text("加载更多..."),
                  )
                ],
              ),
              padding: EdgeInsets.all(15),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _page = 1;
      _load = 1;
    });
    await _initData(_page);
  }

  Future<void> _onLoadMore() async {
    if (_load == 3) return;
    setState(() {
      _load = 2;
    });
    await _initData(_page);
  }

  @override
  bool get wantKeepAlive => true;
}
