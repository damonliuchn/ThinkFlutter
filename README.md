# ThinkFlutter

一个Flutter的工程模板，使用了flutterw、flutter web、dartserver、dio、serializable、retrofit、toast、cached_network_image、provider、eventbus、isolate、本地图片、iconfonts 并演示了package、plugin开发方式，此为第一版后续不断完善。

## 一、第三方库的使用
1. flutterw
3. dio
4. serializable
5. retrofit
8. 页面跳转
2. dartserver
9. toast
9. flutter web工程兼容处理
12. provider
14. package 开发及引用
16. plugin 开发及引用
14. eventbus
15. isolate
16. cached_network_image
17. 本地图片、icon fonts的使用

## 二、启动
```java
./flutterw pub get
./flutterw pub run build_runner build
```


### （一）可以使用flutterw版本切换
```java
./flutterw channel stable
./flutterw upgrade
./flutterw version -f "v1.9.1+hotfix.6"
```
[flutterw 源码地址][1]

### （二）启动flutter web
```java
./flutterw config --enable-web
./flutterw run -d chrome
./flutterw build web

#使用dart server部署flutter web
./flutterw dart tool/server.dart  
# 注意：每次代码更新后需重新./flutterw build web，并且 ctrl f5 强制刷新浏览器生效
```
[dart server 源码地址][2]

## TODO
1. 添加android工程 支持打包aar和apk 
2. tool改名others
3. rxdart
4. redux
5. isolate flutter web的问题


## Thanks
https://github.com/leiyun1993/FlutterDemo-GankIO

  [1]: https://github.com/MasonLiuChn/flutterw
  [2]: https://github.com/MasonLiuChn/DartServer
