import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/Corporation.dart';
import 'package:stock_management_ui/service/CorporationService.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/HomePage.dart';

class AccountCreatePage2 extends StatefulWidget {
  @override
  _AccountCreatePage2State createState() => _AccountCreatePage2State();
}

class _AccountCreatePage2State extends State<AccountCreatePage2> {
  final corporationController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late BuildContext _buildContext;

  Account account = Account();

  Future<List<Corporation>> getSuggestions(String query) async {
    final corpList = await CorporationService.list(_buildContext);

    List<Corporation> list = [];
    for (var c in corpList) {
      final nameLower = c.name!.toLowerCase();
      final queryLower = query.toLowerCase();

      if (nameLower.contains(queryLower)) {
        list.add(c);
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hesap Ekle"),
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
                      decoration: InputDecoration(
                        labelText: "Hesap Adı",
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Hesap adı giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        account.name = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TypeAheadFormField<Corporation?>(
                      hideSuggestionsOnKeyboardHide: false,
                      validator: (value) {
                        if (value == null) {
                          return "Kurum seçiniz";
                        }

                        if (value.isEmpty) {
                          return "Kurum Seçin";
                        }
                      },
                      debounceDuration: Duration(milliseconds: 500),
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: corporationController,
                        decoration: InputDecoration(
                            labelText: "Kurum Adı",
                            prefixIcon: Icon(Icons.account_balance_outlined),
                            border: OutlineInputBorder(),
                            hintText: "Kurum ara"),
                      ),
                      suggestionsCallback: getSuggestions,
                      itemBuilder: (context, Corporation? suggestion) {
                        return ListTile(
                          title: Text(suggestion!.name!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        corporationController.text = suggestion!.name!;
                        account.corporationId = suggestion.id;
                      },
                      noItemsFoundBuilder: (context) {
                        return Container(
                          height: 80,
                          child: Center(
                            child: Text("Kurum bulunamadı"),
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
                        labelText: "Komisyon Oranı",
                        prefixIcon: Icon(Icons.money_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Komisyon oranı giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        account.commissionRate = double.tryParse(value!)!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    child: Text("Create"),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        print("validate error");
                        return;
                      }

                      formKey.currentState!.save();

                      postData();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void postData() async {
    HttpUtil.post(
        UrlBuilder.accountSave(), account.toJson(), onSuccess, onError);
  }

  void onSuccess() {
    showDialog(
            context: _buildContext,
            builder: (context) {
              return AlertDialog(
                title: Text("Hesap Başarıyla Oluşturuldu"),
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
