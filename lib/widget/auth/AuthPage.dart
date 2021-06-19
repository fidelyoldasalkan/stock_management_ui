import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_ui/widget/auth/LoginPage.dart';
import 'package:stock_management_ui/widget/auth/SignUpPage.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool login = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Portföy Yönetimi"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Giriş Yap",
                ),
                Tab(
                  text: "Kayıt Ol",
                )
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                LoginPage(),
                SignUpPage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
