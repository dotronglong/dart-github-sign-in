import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class GitHubSignInPage extends StatefulWidget {
  final String url;
  final String redirectUrl;
  final bool clearCache;
  final String title;
  final String userAgent;

  const GitHubSignInPage(
      {Key key,
      @required this.url,
      @required this.redirectUrl,
      this.userAgent,
      this.clearCache = true,
      this.title = ""})
      : super(key: key);

  @override
  State createState() => _GitHubSignInPageState();
}

class _GitHubSignInPageState extends State<GitHubSignInPage> {
  final FlutterWebviewPlugin _wv = FlutterWebviewPlugin();

  static const String _userAgentMacOSX =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36";

  @override
  void initState() {
    super.initState();
    _wv.onUrlChanged.listen((url) {
      if (url.startsWith(widget.redirectUrl)) {
        Navigator.of(context)
            .pop(url.replaceFirst("${widget.redirectUrl}?code=", "").trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      userAgent: widget.userAgent ?? _userAgentMacOSX,
      withZoom: false,
      withLocalStorage: false,
      withJavascript: true,
      clearCache: widget.clearCache,
      clearCookies: widget.clearCache,
      initialChild: Container(
        color: Theme.of(context).primaryColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _wv.dispose();
    _wv.close();
  }
}
