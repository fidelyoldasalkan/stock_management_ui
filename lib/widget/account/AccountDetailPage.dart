import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesay Detayı"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hesap Adı"),
                Text("Z1"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Komisyon Oranı"),
                Text("0.0015"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kurumu"),
                Text("ABC Kurum"),
              ],
            ),
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
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.edit),
            onPressed: () {},
            label: Text("Düzenle"),
          ),
        ],
      ),
    );
  }
}
