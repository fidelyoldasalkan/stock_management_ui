import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/Exchange.dart';
import 'package:stock_management_ui/model/Stock.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/service/StockService.dart';
import 'package:stock_management_ui/util/DateUtil.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';

import '../HomePage.dart';

class ExchangeCreatePage extends StatefulWidget {

  @override
  _ExchangeCreatePageState createState() => _ExchangeCreatePageState();
}

class _ExchangeCreatePageState extends State<ExchangeCreatePage> {

  final _accountController = TextEditingController();
  final _dateController = TextEditingController();
  final _stockController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Exchange exchange = Exchange();
  late BuildContext _buildContext;


  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("İşlemlerim"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
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
                        exchange.accountId = suggestion.id;
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
                        exchange.stock = suggestion.shortCode;
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
                        exchange.lot = int.tryParse(value!)!;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Fiyat",
                        prefixIcon: Icon(Icons.money_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Fiyat bilgisini giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        exchange.price = double.tryParse(value!)!;
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Kaydet"),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            print("validate error");
                            return;
                          }

                          _formKey.currentState!.save();

                          postData();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5)
    );

    if (newDate == null) return;
    exchange.date = DateUtil.apiDate(newDate);
    _dateController.text = DateUtil.ddMmYy(newDate);

  }

  Future<List<Account>> getSuggestion(String query) async {
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

  void postData() {
    HttpUtil.post(
        UrlBuilder.exchangeSave(), exchange.toJson(), onSuccess, onError);
  }

  void onSuccess() {
    showDialog(
        context: _buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text("İşlem Kaydedildi"),
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
}