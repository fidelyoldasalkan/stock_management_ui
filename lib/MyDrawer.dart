import 'package:flutter/material.dart';
import 'package:stock_management_ui/widget/account/AccountListPage.dart';
import 'package:stock_management_ui/widget/dividend/DividendListPage.dart';
import 'package:stock_management_ui/widget/exchange/ExchangeListPage.dart';
import 'package:stock_management_ui/widget/moneyFlow/MoneyFlowListPage.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Hesaplarım'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountListPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money_rounded),
            title: Text('Nakit Akışı'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MoneyFlowListPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money_rounded),
            title: Text('Temettü'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DividendListPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money_rounded),
            title: Text('İşlemlerim'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExchangeListPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Create Account'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
