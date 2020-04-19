import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/http.dart';
import 'package:angel_proxy/angel_proxy.dart';
import 'package:angel_static/angel_static.dart';
import 'package:file/local.dart';

final Duration timeout = Duration(seconds: 5);

main(List<String> args) async {
  var app = Angel();

  //启动代理
  var pubProxy = Proxy(
    'http://gank.io',
    publicPath: '',
    timeout: timeout,
  );
  //app.all("/mock/*", pubProxy.handleRequest);
  //app.all('*', pubProxy.handleRequest);
  app.all("/proxy/*", (RequestContext req, res) {
    return pubProxy.servePath(req.path.replaceAll("proxy/", ""), req, res);
  });

  //启动本地文件夹映射
  var fs = const LocalFileSystem();
  var vDir = CachingVirtualDirectory(
    app,
    fs,
    allowDirectoryListing: true,
    source: fs.currentDirectory.childDirectory("build").childDirectory("web"),
    maxAge: const Duration(days: 24).inSeconds,
  );
  app.fallback(vDir.handleRequest);

  //启动本地接口监听
  var http = AngelHttp(app);
  var server = await http.startServer('127.0.0.1', 3000);
  print('Serving from ${vDir.source.path}');
  print(
      'Test proxy at http://${server.address.address}:${server.port}/proxy/packages/toast');
  print('Listening at http://${server.address.address}:${server.port}');//${server.address.address}
}
