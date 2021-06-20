import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/model/Stock.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/service/DividendService.dart';
import 'package:stock_management_ui/service/StockService.dart';
import 'package:stock_management_ui/util/DateUtil.dart';
import 'package:stock_management_ui/util/SharedPref.dart';

import '../HomePage.dart';

class DividendCreatePage extends StatefulWidget {
  @override
  _DividendCreatePageState createState() => _DividendCreatePageState();
}

class _DividendCreatePageState extends State<DividendCreatePage> {
  final _accountController = TextEditingController();
  final _stockController = TextEditingController();
  final _dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late BuildContext _buildContext;
  final _sharedPref = SharedPref.getInstance();

  Dividend dividend = Dividend();

  _DividendCreatePageState() {
    initAccount();
    initDate();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Temettü Girişi"),
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
                    child: FocusScope(
                      node: FocusScopeNode(canRequestFocus: false),
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
                        },
                      ),
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
                          labelText: "Hesap",
                          prefixIcon: Icon(Icons.account_balance_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: getAccountSuggestion,
                      itemBuilder: (context, Account? suggestion) {
                        return ListTile(
                          title: Text(suggestion!.name!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _accountController.text = suggestion!.name!;
                        dividend.accountId = suggestion.id;
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
                    padding: EdgeInsets.all(8),
                    child: TypeAheadFormField<Stock?>(
                      validator: (value) {
                        if (value == null) {
                          return "Hisse seçiniz";
                        }

                        if (value.isEmpty) {
                          return "Hisse Seçin";
                        }
                      },
                      hideSuggestionsOnKeyboardHide: false,
                      debounceDuration: Duration(milliseconds: 500),
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _stockController,
                        decoration: InputDecoration(
                          labelText: "Hisse",
                          prefixIcon: Icon(Icons.account_balance_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: getStockSuggestion,
                      itemBuilder: (context, Stock? suggestion) {
                        return ListTile(
                          title: Text(suggestion!.shortCode!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _stockController.text = suggestion!.shortCode!;
                        dividend.stock = suggestion.shortCode;
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
                        labelText: "Lot",
                        prefixIcon: Icon(Icons.scatter_plot_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Lot bilgisini giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        dividend.lot = int.tryParse(value!)!;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lot Başı Tutar",
                        prefixIcon: Icon(Icons.money_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Tutar bilgisini giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        dividend.amount = double.tryParse(value!)!;
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Kaydet"),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            print("validate error");
                            return;
                          }

                          formKey.currentState!.save();

                          DividendService.save(context, dividend.toJson(), onSuccess: onSuccess, onError: onError);
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

  Future<List<Account>> getAccountSuggestion(String query) async {
    var list = await AccountService.list(_buildContext);
    return list.where((account) {
      final nameLower = account.name!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  Future<List<Stock>> getStockSuggestion(String query) async {
    var list = await StockService.list(_buildContext);
    return list.where((account) {
      final nameLower = account.name!.toLowerCase();
      final shortCodeLower = account.shortCode!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) || shortCodeLower.contains(queryLower);
    }).toList();
  }

  void onSuccess(GeneralResponse? generalResponse) {
    showDialog(
        context: _buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text("Temettü Kaydedildi"),
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

  void onError(GeneralResponse? generalResponse) {}

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5)
    );

    if (newDate == null) return;
    dividend.date = DateUtil.apiDate(newDate);
    _dateController.text = DateUtil.ddMmYy(newDate);

  }

  void initAccount() async {
    String? accountName = await _sharedPref.loadDefaultAccountName();
    int? accountId = await _sharedPref.loadDefaultAccountId();

    if (accountName != null && accountId != 0) {
      setState(() {
        _accountController.text = accountName;
        dividend.accountId = accountId;
      });
    }
  }

  void initDate() {
    final now = DateTime.now();
    _dateController.text = DateUtil.ddMmYy(now);
    dividend.date = DateUtil.apiDate(now);
  }
}
