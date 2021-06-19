import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_management_ui/request/LoginRequest.dart';
import 'package:stock_management_ui/util/HttpUtil.dart';
import 'package:stock_management_ui/util/UrlBuilder.dart';
import 'package:stock_management_ui/widget/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginRequest loginRequest = LoginRequest();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool passwordInvisible = true;
  bool waiting = false;

  void submitData() async {
    setState(() {
      print("A");
      waiting = true;
    });
    HttpUtil.post(
        UrlBuilder.login(), loginRequest.toJson(), onSuccess, onError);
  }

  void onSuccess() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (r) => false);
    setState(() {
      waiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: buildForm(),
        ),
      ),
    );
  }

  Widget buildPasswordIcon(BuildContext context) {
    return passwordInvisible
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
  }

  Widget buildForm() {
    return waiting
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Email giriniz";
                    }

                    // if (!EmailValidator.validate(value)) {
                    //   return "Geçerli email adresi giriniz";
                    // }
                  },
                  onSaved: (String? value) {
                    loginRequest.username = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    suffixIcon: InkWell(
                      onTap: () => {
                        setState(() {
                          passwordInvisible = !passwordInvisible;
                        })
                      },
                      child: buildPasswordIcon(context),
                    ),
                  ),
                  obscureText: passwordInvisible,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Şifre giriniz";
                    }
                  },
                  onSaved: (String? value) {
                    loginRequest.password = value!;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Şifremi Unuttum"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          print("Validate error");
                        }

                        formKey.currentState!.save();

                        submitData();
                      },
                      child: Text("Giriş Yap"),
                    )
                  ],
                )
              ],
            ),
          );
  }

  void onError() {}
}
