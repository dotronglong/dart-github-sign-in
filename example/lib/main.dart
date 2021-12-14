import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter GitHub Demo'),
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
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: 'abd975f97f953c6e1843',
      clientSecret: '709fb6441354c8d148248ae2cab0673b4ce7f1d5',
      redirectUrl: 'https://l2t-flutter.firebaseapp.com/__/auth/handler',
      title: 'GitHub Connection',
      centerTitle: false,
  );

  void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _gitHubSignIn(context);
          },
          child: Text("GitHub Connection"),
        ),
      ),
    );
  }
}
