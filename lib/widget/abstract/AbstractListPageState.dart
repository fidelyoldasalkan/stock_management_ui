import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_management_ui/dto/GeneralResponse.dart';
import 'package:stock_management_ui/model/BaseModel.dart';
import 'package:stock_management_ui/util/MyDio.dart';

abstract class AbstractListPageState<T extends BaseModel> extends State {
  bool _isFirst = true;

  String createButtonTitle;

  String title;

  late BuildContext _buildContext;

  AbstractListPageState(this.title, this.createButtonTitle);

  String apiUri();

  void onSuccess(GeneralResponse? generalResponse);

  void onError(GeneralResponse? generalResponse);

  T mapper(Map<String, dynamic> json);

  Widget createPage();

  Widget noFoundData();

  void onTapRow(T data);

  List<Widget> row(T data);

  Future? delete(int id);

  void edit(T data);

  Future<List<T>> fetchData() async {
    final generalResponse = await MyDio(_buildContext).get(apiUri(), onSuccess: onSuccess, onError: onError);
    // var jsonData = await HttpUtil.get(apiUri(), onSuccess, onError);

    List<T> list = [];
    for (var json in generalResponse.data) {
      list.add(mapper(json));
    }

    _isFirst = list.isEmpty;

    return list;
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
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
                      child: Card(
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: [
                            IconSlideAction(
                              caption: 'Düzenle',
                              color: Colors.blue,
                              icon: Icons.edit,
                              onTap: () {
                                edit(snapshot.data![index]);
                              },
                            ),
                            IconSlideAction(
                              caption: 'Sil',
                              color: Colors.redAccent,
                              icon: Icons.delete,
                              onTap: () {
                                _delete(snapshot.data![index].id!);
                              },
                            )
                          ],
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(
                                color: Colors.blue,
                                width: 2
                              ))
                            ),
                            child: Row(
                              children: row(snapshot.data![index]),
                            ),
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
