import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/MoneyFlow.dart';
import 'package:stock_management_ui/model/enums/MoneyFlowType.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/util/DateUtil.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';

import '../HomePage.dart';

class MoneyFlowCreatePage extends StatefulWidget {

  @override
  _MoneyFlowCreatePageState createState() => _MoneyFlowCreatePageState();
}

class _MoneyFlowCreatePageState extends State<MoneyFlowCreatePage> {
  final _accountController = TextEditingController();
  final _dateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  late BuildContext _buildContext;

  MoneyFlow moneyFlow = MoneyFlow();

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nakit Akış Girişi"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dateController,
                      onTap: () => pickDate(context),
                      decoration: InputDecoration(
                        labelText: "Tarih Seçin",
                        prefixIcon: Icon(Icons.date_range_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Tarih seçiniz";
                        }
                      },
                      onSaved: (String? value) {
                        moneyFlow.date = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TypeAheadFormField<Account?>(
                      validator: (value) {
                        if (value == null) {
                          return "Hesap seçiniz";
                        }

                        if (value.isEmpty) {
                          return "Hesap Seçin";
                        }
                      },
                      hideSuggestionsOnKeyboardHide: false,
                      debounceDuration: Duration(milliseconds: 500),
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _accountController,
                        decoration: InputDecoration(
                          labelText: "Hesap Adı",
                          prefixIcon: Icon(Icons.account_balance_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: getSuggestion,
                      itemBuilder: (context, Account? suggestion) {
                        return ListTile(
                          title: Text(suggestion!.name!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _accountController.text = suggestion!.name!;
                        moneyFlow.accountId = suggestion.id;
                      },
                      noItemsFoundBuilder: (context) {
                        return Container(
                          height: 80,
                          child: Center(
                            child: Text("Hesap bulunamadı"),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Para Tutarı",
                        prefixIcon: Icon(Icons.money_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Para tutarı giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        moneyFlow.amount = double.tryParse(value!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Para Çek"),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            print("validate error");
                            return;
                          }

                          formKey.currentState!.save();

                          postData(MoneyFlowType.WITHDRAW.toString());
                        },
                      ),
                      ElevatedButton(
                        child: Text("Para Yatır"),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            print("validate error");
                            return;
                          }

                          formKey.currentState!.save();

                          postData(MoneyFlowType.DEPOSIT.toString());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<List<Account>> getSuggestion(String query) async {
    var list = await AccountService.list(_buildContext);
    return list.where((account) {
      final nameLower = account.name!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  void postData(String moneyFlowType) {
    moneyFlow.moneyFlowType = moneyFlowType == "MoneyFlowType.DEPOSIT" ? "DEPOSIT" : "WITHDRAW" ;
    HttpUtil.post(
        UrlBuilder.saveMoneyFlow(), moneyFlow.toJson(), onSuccess, onError);
  }

  void onSuccess() {
    showDialog(
        context: _buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text("Nakit Akışı Kaydedildi"),
            content: ElevatedButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                        (r) => false);
              },
            ),
          );
        })
        .then((value) => Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (r) => false));
  }

  void onError() {}

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5)
    );

    if (newDate == null) return;
    moneyFlow.date = DateUtil.apiDate(newDate);
    _dateController.text = DateUtil.ddMmYy(newDate);

  }
}
