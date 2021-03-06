import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/Corporation.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/service/CorporationService.dart';
import 'package:stock_management_ui/util/SharedPref.dart';
import 'package:stock_management_ui/widget/HomePage.dart';

class AccountCreatePage extends StatefulWidget {

  Account? account;
  String pageTitle;

  AccountCreatePage(this.pageTitle, {this.account});

  @override
  _AccountCreatePageState createState() => _AccountCreatePageState(this.pageTitle, this.account);
}

class _AccountCreatePageState extends State<AccountCreatePage> {
  final _corporationController = TextEditingController();
  final _nameController = TextEditingController();
  final _commissionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late BuildContext _buildContext;
  final _sharedPref = SharedPref.getInstance();

  Account account = Account();
  String pageTitle;

  _AccountCreatePageState(this.pageTitle, [Account? account]) {
    if (account != null) {
      this.account = account;
      _corporationController.text = account.corporationName!;
      _nameController.text = account.name!;
      _commissionController.text = "${account.commissionRate!}";
    }
  }

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
        title: Text(this.pageTitle),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Hesap Ad??",
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Hesap ad?? giriniz";
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
                          return "Kurum se??iniz";
                        }

                        if (value.isEmpty) {
                          return "Kurum Se??in";
                        }
                      },
                      debounceDuration: Duration(milliseconds: 500),
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _corporationController,
                        decoration: InputDecoration(
                            labelText: "Kurum Ad??",
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
                        _corporationController.text = suggestion!.name!;
                        account.corporationId = suggestion.id;
                      },
                      noItemsFoundBuilder: (context) {
                        return Container(
                          height: 80,
                          child: Center(
                            child: Text("Kurum bulunamad??"),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _commissionController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Komisyon Oran??",
                        prefixIcon: Icon(Icons.money_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Komisyon oran?? giriniz";
                        }
                      },
                      onSaved: (String? value) {
                        account.commissionRate = double.tryParse(value!)!;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Varsay??n Hesap Olarak Belirle", style: TextStyle(fontSize: 24, color: Colors.blueGrey),),
                      Switch.adaptive(value: account.isDefault!, onChanged: (value) {
                        setState(() {
                          account.isDefault = !account.isDefault!;
                        });
                      } ),
                    ],
                  ),),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.save_outlined),
                    label: Text("Kaydet"),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        print("validate error");
                        return;
                      }

                      formKey.currentState!.save();

                      _sharedPref.saveDefaultAccount(account);
                      AccountService.save(context, account.toJson(), onSuccess: onSuccess, onError: onError);
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

  void onSuccess(GeneralResponse? generalResponse) {
    showDialog(
            context: _buildContext,
            builder: (context) {
              return AlertDialog(
                title: Text("Hesap Ba??ar??yla Olu??turuldu"),
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
}
