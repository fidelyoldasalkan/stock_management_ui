import 'package:flutter/material.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/Dividend.dart';
import 'package:stock_management_ui/my_icons_icons.dart';
import 'package:stock_management_ui/service/DividendService.dart';
import 'package:stock_management_ui/widget/abstract/AbstractListPageState.dart';
import 'package:stock_management_ui/widget/dividend/DividendCreatePage.dart';


class DividendListPage extends StatefulWidget {
  @override
  _DividendListPageState createState() => _DividendListPageState();
}

class _DividendListPageState extends AbstractListPageState<Dividend> {
  _DividendListPageState() : super("Temettülerim", "Temettü Ekle");

  @override
  String apiUri() {
    return ServicePath.DIVIDEND_LIST;
  }

  @override
  Widget createPage() {
    return DividendCreatePage();
  }

  @override
  Future? delete(int id) async {
    await DividendService.delete(context, id);
    return null;
  }

  @override
  Dividend mapper(Map<String, dynamic> json) {
    return Dividend.fromJson(json);
  }

  @override
  Widget noFoundData() {
    return Text("Temettü işleminiz bulunmamaktadır");
  }

  @override
  void onError(GeneralResponse? generalResponse) {
    // TODO: implement onError
  }

  @override
  void onSuccess(GeneralResponse? generalResponse) {
    // TODO: implement onSuccess
  }

  @override
  void onTapRow(Dividend data) {
    // TODO: implement onTapRow
  }

  @override
  List<Widget> row(Dividend data) {
    return [
      Expanded(flex: 1, child: Icon(MyIcons.dividend, color: Colors.green,)),
      Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.stock!),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text("${data.lot! * data.amount!}"),
        ),
      )
    ];
  }

  @override
  void edit(Dividend data) {
    // TODO: implement edit
  }
}
