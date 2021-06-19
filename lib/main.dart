import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_ui/widget/auth/AuthPage.dart';

void main() {
  runApp(StockManagementApp());
}

class StockManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthPage();
  }
}
