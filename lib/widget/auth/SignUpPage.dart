import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Username"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("SignUp"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
