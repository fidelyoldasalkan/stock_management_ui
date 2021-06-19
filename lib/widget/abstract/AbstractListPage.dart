import 'package:flutter/material.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/BaseModel.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';

abstract class AbstractListPage<T extends BaseModel> extends StatelessWidget {

  String title;
  String createButtonTitle;
  bool _isFirst = true;

  AbstractListPage(this.title, this.createButtonTitle);

  Uri apiUri();
  void onSuccess();
  void onError();
  T mapper(Map<String, dynamic> json);
  Widget createPage();
  Widget noFoundData();
  void onTapRow(T data);
  Widget row(T data);

  Future<List<T>> fetchData() async {
    var jsonData = await HttpUtil.get(apiUri(), onSuccess, onError);

    List<T> list = [];
    for (var json in jsonData) {
      list.add(mapper(json));
    }

    _isFirst = list.isEmpty;

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => createPage()));
            },
            child: Text(createButtonTitle),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<T>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (_isFirst == true) {
              return Center(
                child: noFoundData(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTapRow(snapshot.data![index]);
                  },
                  child: row(snapshot.data![index])
                );
              },
            );
          },
        ),
      ),
    );
  }


}
