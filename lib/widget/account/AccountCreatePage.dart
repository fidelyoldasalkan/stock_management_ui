
import 'package:flutter/material.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/Corporation.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/HomePage.dart';

class AccountCreatePage extends StatefulWidget {
  AccountCreatePage({Key? key}) : super(key: key);

  @override
  _AccountCreatePageState createState() => _AccountCreatePageState();
}

class _AccountCreatePageState extends State<AccountCreatePage> {
  Account account = Account();
  late BuildContext _buildContext;

  List<Corporation> corporationList = [];

  Corporation selectedCorp = Corporation(0, "DEFAULT", "111");

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Account Name"),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Account Name is required";
                  }
                },
                onSaved: (String? value) {
                  account.name = value!;
                },
              ),
              DropdownButtonFormField(
                  hint: Text("Select Corporation"),
                  value: selectedCorp,
                  onChanged: (value) {},
                  onSaved: (Corporation? value) {
                    account.corporationId = selectedCorp.id;
                  },
                  validator: (Corporation? value) {
                    if (value!.name!.isEmpty) {
                      return "must be selected";
                    }
                  },
                  items: corporationList.map((valueItem) {
                    return DropdownMenuItem(
                        child: Text(valueItem.name!.substring(0, 10)),
                        value: valueItem);
                  }).toList()),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Commission"),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Commission is required";
                  }
                },
                onSaved: (String? value) {
                  account.commissionRate = double.tryParse(value!)!;
                },
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
    );
  }

  void fetchData() async {
    var jsonData = await HttpUtil.get(
        UrlBuilder.corporationList(), () {}, () {});

    List<Corporation> list = [];
    for (var json in jsonData) {
      list.add(Corporation(json['id'], json['name'], json['imageUrl']));
    }

    setState(() {
      selectedCorp = list[0];
      corporationList = list;
    });
  }

  void postData() async {
    HttpUtil.post(
        UrlBuilder.accountSave(), account.toJson(), onSuccess, onError);
  }

  void onSuccess() {
    showDialog(context: _buildContext, builder: (context) {
      return AlertDialog(
        title: Text("Hesap Başarıyla Oluşturuldu"),
        content: ElevatedButton(
          child: Text("Tamam"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => HomePage()), (r) => false);
          },
        ),
      );
    }).then((value) =>
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => HomePage()), (r) => false));
  }

  void onError() {

  }
}
