import 'package:flutter/material.dart';
import 'package:stock_management_ui/MyDrawer.dart';
import 'package:stock_management_ui/widget/account/AccountCard.dart';
import 'package:stock_management_ui/widget/dividend/DividendCard.dart';
import 'package:stock_management_ui/widget/exchange/ExchangeCard.dart';
import 'package:stock_management_ui/widget/moneyFlow/MoneyFlowCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hisse Yönetimi"),
        ),
        drawer: MyDrawer(),
        body: SafeArea(
          child: ListView(
            children: [
              AccountCard(),
              MoneyFlowCard(),
              ExchangeCard(),
              DividendCard(),
            ],
          ),
        ),
      ),
    );
  }
}
