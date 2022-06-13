import 'dart:convert';

import 'package:avenue/controller/api.dart';
import 'package:avenue/share_prefe.dart';
import 'package:avenue/view/bottom_view/bottom_view.dart';
import 'package:avenue/view/register/register.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routers.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visibleLoading = false;

  Future login({required TextEditingController name, required TextEditingController password, required BuildContext context,
      required Widget widget}) async {
    String getEmail = name.text;
    String getPassword = password.text;

    setState(() {
      visibleLoading = true;
    });

    var data = {"email": getEmail, "password": getPassword};
    var request = await Dio()
        .post(ApiConstant().baseUrl + ApiConstant().login, data: data);

    var decode = jsonDecode(request.data);

    if (decode[4] == "Successfully login") {
      setState(() {
        visibleLoading = false;
      });
      prefLogin(id: decode[0], name: decode[1], email: decode[2], photo: '');
      pushPageRemove(context, widget);
    } else {
      setState(() {
        visibleLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Nama atau Email belum terdaftar, silakan daftar terlebih dahulu',
                style: TextStyle(color: Colors.blueAccent, fontSize: 18),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Paham'),
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    prefLoad().then((value) {
      setState((){
        if(value != null){
          pushPageRemove(context, BottomView());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset("assets/image/login.png", width: 120, height: 120),
                Text(
                  'Silahakan login untuk melanjutkan',style: TextStyle( color: Colors.lightBlue, fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 10),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Masukkan Email Anda',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white70,
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent))),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                  child: TextField(
                    controller: passwordController,
                    autocorrect: true,
                    obscureText: true,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Masukkan Password Anda',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white70,
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent))),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      login(name: emailController,
                      password: passwordController,
                      context: context, widget: BottomView());
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            right: 20, left: 20, top: 10, bottom: 10),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 7, left: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blueAccent),
                        child: !visibleLoading
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Visibility(
                                visible: visibleLoading,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum Punya Akun?',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            pushPage(context, EbookRegister());
                          },
                          child: Text(
                            'Daftar',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
