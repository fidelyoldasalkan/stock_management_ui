import 'package:flutter/material.dart';
import 'package:stock_management_ui/model/BaseModel.dart';
import 'package:stock_management_ui/util/MyDio.dart';

abstract class AbstractCard<T extends BaseModel> extends StatelessWidget {
  final String title;
  final String url;
  bool isFirst = false;
  late BuildContext _buildContext;

  AbstractCard(this.title, this.url);

  Future<List<T>> fetchData() async {
    final generalResponse = await MyDio(_buildContext).get(url);

    List<T> list = [];
    for (var json in generalResponse.data!) {
      list.add(mapper(json));
    }

    isFirst = list.isEmpty;

    return list;
  }

  T mapper(dynamic json);

  Widget leftWidget(T data);

  Widget rightWidget(T data);

  void onRowTap(T data);

  Widget noFoundDataWidget();

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadiusDirectional.circular(10)),
      height: 200,
      alignment: Alignment.centerLeft,
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          child: ListView(children: [
            Container(
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.blue, width: 2))),
              child: Text(title),
            ),
            Container(
              height: 150,
              child: FutureBuilder<List<T>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return noFoundDataWidget();
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            onRowTap(snapshot.data![index]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: leftWidget(snapshot.data![index]),
                                color: Colors.green,
                                padding: EdgeInsets.all(10),
                              ),
                              Container(
                                child: rightWidget(snapshot.data![index]),
                                color: Colors.yellow,
                                padding: EdgeInsets.all(10),
                              ),
                            ],
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
            )
          ]),
        ),
      ),
    );
  }
}
