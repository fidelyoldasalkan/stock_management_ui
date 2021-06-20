import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_management_ui/constant/ServicePath.dart';
import 'package:stock_management_ui/model/Exchange.dart';
import 'package:stock_management_ui/widget/AbstractCard.dart';

class ExchangeCard extends AbstractCard<Exchange> {
  ExchangeCard() : super("İşlemler", ServicePath.EXCHANGE_LIST);

  @override
  Exchange mapper(json) {
    return Exchange(
      json['id'],
      json['accountId'],
      json['stock'],
      json['lot'],
      json['price'],
      json['date'],
      json['commission'],
    );
  }

  @override
  Widget leftWidget(Exchange data) {
    return Text(data.stock!);
  }

  @override
  Widget rightWidget(Exchange data) {
    return Text("${data.lot! * data.price!} ₺");
  }

  @override
  void onRowTap(Exchange data) {
    // TODO: implement onRowTap
  }

  @override
  Widget noFoundDataWidget() {
    return Text("Menkul kıymet alım satım işleminiz bulunmamaktadır.");
  }
}
