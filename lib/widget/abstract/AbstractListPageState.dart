import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_management_ui/model/Account.dart';
import 'package:stock_management_ui/model/BaseModel.dart';
import 'package:stock_management_ui/service/AccountService.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';

abstract class AbstractListPageState<T extends BaseModel> extends State {
  bool _isFirst = true;

  String createButtonTitle;

  String title;

  AbstractListPageState(this.title, this.createButtonTitle);

  Uri apiUri();

  void onSuccess();

  void onError();

  T mapper(Map<String, dynamic> json);

  Widget createPage();

  Widget noFoundData();

  void onTapRow(T data);

  List<Widget> row(T data);

  Future? delete(int id);

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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Card(
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: [
                            IconSlideAction(
                              caption: 'Sil',
                              color: Colors.redAccent,
                              icon: Icons.delete,
                              onTap: () {
                                _delete(snapshot.data![index].id!);
                              },
                            )
                          ],
                          child: Row(
                            children: row(snapshot.data![index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _delete(int id) async {
    await delete(id);
    setState(() {});
  }

}
