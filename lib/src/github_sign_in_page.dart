import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class GitHubSignInPage extends StatefulWidget {
  final String url;
  final String redirectUrl;
  final bool clearCache;
  final String title;
  final String? userAgent;

  const GitHubSignInPage(
      {Key? key,
      required this.url,
      required this.redirectUrl,
      this.userAgent,
      this.clearCache = true,
      this.title = ""})
      : super(key: key);

  @override
  State createState() => _GitHubSignInPageState();
}

class _GitHubSignInPageState extends State<GitHubSignInPage> {
  static const String _userAgentMacOSX =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36";

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _launchURL();
    }
  }

  void _launchURL() async => await canLaunch(widget.url)
      ? await launch(widget.url)
      : throw 'Could not launch $widget.url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text(widget.title),
        ),
        body: WebView(
          initialUrl: widget.url,
          userAgent: widget.userAgent ?? _userAgentMacOSX,
          onPageFinished: (url) {
            if (url.startsWith(widget.redirectUrl)) {
              Navigator.of(context).pop(
                  url.replaceFirst("${widget.redirectUrl}?code=", "").trim());
            } else if (url.contains("error=")) {
              Navigator.of(context).pop(
                Exception(Uri.parse(url).queryParameters["error"]),
              );
            }
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    // _wv.dispose();
    // _wv.close();
  }
}
