import 'package:flutter/material.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/model/Exchange.dart';
import 'package:stock_management_ui/model/MoneyFlow.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/util/DateUtil.dart';
import 'package:stock_management_ui/widget/account/AccountCreatePage.dart';

class AccountDetailPage extends StatelessWidget {
  Account _account;
  late BuildContext _buildContext;

  AccountDetailPage(this._account);

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesay Detayı"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Hesap Adı"),
                            Text(_account.name!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Komisyon Oranı"),
                            Text("${_account.commissionRate}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Kurumu"),
                            Text(_account.corporationName!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Hesap İşlem Geçmişi",
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FutureBuilder<Account>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.transactionList!.isEmpty) {
                          return Center(
                              child: Text("Hesap işlem geçmişi bulunmamaktadır."));
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.transactionList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                //onRowTap(snapshot.data![index]);
                              },
                              child: Container(
                                height: 100,
                                child: Card(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: rowWidget(snapshot
                                          .data!.transactionList![index])),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.delete),
            onPressed: () {},
            label: Text("Sil"),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountCreatePage("Hesap Düzenle", account: _account,)));
            },
            label: Text("Düzenle"),
          ),
        ],
      ),
    );
  }

  Future<Account> fetchData() async {
    var response = await AccountService.detail(_buildContext, _account.id!);

    return Account.fromJson(response.data);
  }

  List<Widget> rowWidget(dynamic data) {
    if (data['className'] == "Dividend") {
      Dividend d = Dividend.fromJson(data);
      return dividendRowWidget(d);
    } else if (data['className'] == "MoneyFlow") {
      MoneyFlow mf = MoneyFlow.fromJson(data);
      return moneyFlowRowWidget(mf);
    } else if (data['className'] == "Exchange") {
      Exchange e = Exchange.fromJson(data);
      return exchangeRowWidget(e);
    }
    return [Center(child: Text("Null"))];
  }

  List<Widget> moneyFlowRowWidget(MoneyFlow mf) {
    return [
      Expanded(
        child: Center(
          child: mf.moneyFlowType == 'DEPOSIT'
              ? Icon(
                  Icons.arrow_circle_up_rounded,
                  color: Colors.green,
                )
              : Icon(
                  Icons.arrow_circle_down_rounded,
                  color: Colors.red,
                ),
        ),
        flex: 1,
      ),
      Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mf.moneyFlowType == 'DEPOSIT'
                ? Text("Para Girişi")
                : Text("Para Çıkışı"),
            Text(mf.accountName!),
            Text(
              DateUtil.ddMmYyStr(mf.date),
            )
          ],
        ),
      ),
      Expanded(
        child: Center(
          child: Text("${mf.amount}"),
        ),
      ),
    ];
  }

  List<Widget> dividendRowWidget(Dividend d) {
    return [
      Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(d.stock!),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text("${d.lot! * d.amount!}"),
        ),
      )
    ];
  }

  List<Widget> exchangeRowWidget(Exchange e) {
    return [
      Expanded(
        flex: 1,
        child: Center(
          child: e.exchangeType == 'BUY'
              ? Icon(
            Icons.compare_arrows_outlined,
            color: Colors.green,
          )
              : Icon(
            Icons.compare_arrows_outlined,
            color: Colors.red,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hisse : ${e.stock!}"),
              Text("Lot : ${e.lot}"),
              Text("Fiyat : ${e.price} ₺")
            ],
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Tutar : ${e.lot! * e.price!}"),
            Text("Komisyon : ${(e.lot! * e.price! * e.commission! * 100).roundToDouble() / 100 }"),
          ]),
        ),
      ),
    ];
  }
}
