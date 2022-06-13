import 'dart:io';
import 'package:avenue/controller/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../../routers.dart';
import '../login/login.dart';

class EbookRegister extends StatefulWidget{

  @override
  _EbookRegisterState createState() => _EbookRegisterState();
}

class _EbookRegisterState extends State<EbookRegister> {

  File _file = File('');
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visibleLoading = false;

  Future register({required TextEditingController name, required TextEditingController email, required TextEditingController password,
  required BuildContext context, required Widget widget}) async{
    setState(() {
      visibleLoading = true;
    });

    String getName = name.text;
    String getEmail = email.text;
    String getPassword = password.text;

    var request = http.MultipartRequest('POST', Uri.parse(ApiConstant().baseUrl+ApiConstant().register));
    var photo = await http.MultipartFile.fromPath('photo', _file.path);
    request.fields['name'] = getName;
    request.fields['email'] = getEmail;
    request.fields['password'] = getPassword;
    request.files.add(photo);

    var response = await request.send();

    if(response.statusCode == 200){
      setState(() {
        visibleLoading = false;
      });
      pushPage(context,Login());
    }else{
      setState(() {
        visibleLoading = false;
      });
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Nama atau Email sudah terdaftar, silakan gunakan yang lain!', style: TextStyle(
            color: Colors.blueAccent, fontSize: 18
          ),),
          actions: [
            GestureDetector(
              onTap: (){
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Ayo Buat Akunmu Sekarang. Gratis!', style: TextStyle(
                color: Colors.black, fontSize: 20
              ),),
              GestureDetector(
                onTap: (){
                  imagePicker(context);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20,  left: 20, top: 15, bottom: 10),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: _file.path == '' ? Image.asset('assets/image/register.png', width: 35, height: 35, fit: BoxFit.cover,) :
                        Image.file(_file, width: 35, height: 35, fit: BoxFit.cover,)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20,  left: 20, top: 10, bottom: 10),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Anda',
                    prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.black,),
                    filled: true,
                    isDense: true,
                    fillColor: Colors.white70,
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueAccent)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent)
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20,  left: 20, top: 10, bottom: 10),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Masukkan Email Anda',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.black,),
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white70,
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent)
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20,  left: 20, top: 10, bottom: 10),
                child: TextField(
                  controller: passwordController,
                  autocorrect: true,
                  obscureText: true,
                  autofocus: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Masukkan Password Anda',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black,),
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white70,
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent)
                      )
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: (){
                    if(_file.path != ""){
                      if(nameController.text != ""){
                        if(emailController.text != ""){
                          if(passwordController.text != ""){
                            register(name: nameController,
                                email: emailController,
                                password: passwordController,
                                context: context,
                                widget: widget);
                          }else{
                            messageValidation('Password Kosong','Silakan isi Password Anda terlebih dahulu');
                          }
                        }else{
                          messageValidation('Email Kosong','Silakan isi Email Anda terlebih dahulu!');
                        }
                      }else{
                        messageValidation('Nama Kosong','Silakan isi Nama Anda terlebih dahulu!');
                      }
                    }else{
                      messageValidation('Foto Kosong','Silakan pilih foto profil terlebih dahulu!');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20,  left: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.4.h, right: 7.w, left: 7.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueAccent
                    ),
                    child: !visibleLoading ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text('Buat Akun', style: TextStyle(
                        color: Colors.white, fontSize: 17
                      ), textAlign: TextAlign.center,),
                    ) : Visibility(visible: visibleLoading,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.white,),
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah Punya Akun?', style: TextStyle(fontSize: 17, color: Colors.black),),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          pushPage(context, Login());
                        },
                        child: Text('Login', style: TextStyle(color: Colors.blue, fontSize: 17),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  imageFromGallery()async{
    var imageGallery = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(imageGallery != null){
        _file = File(imageGallery.path);
        print("Berhasil ${imageGallery.path}");
      }else{
        print("Tidak Berhasil");
      }
    });
  }

  imageFromCamera()async{
    var imageCamera = await picker.pickImage(source: ImageSource.camera, imageQuality: 100, maxHeight: 100, maxWidth: 100);
    setState(() {
      if(imageCamera != null){
        _file = File(imageCamera.path);
        print("Berhasil ${imageCamera.path}");
      }else{
        print("Tidak Berhasil");
      }
    });
  }

  void imagePicker(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.library_add_sharp, color: Colors.blueAccent,),
                title: Text('Foto dari Galeri', style: TextStyle(color: Colors.blueAccent),),
                onTap: (){
                  imageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blueAccent,),
                title: Text('Foto dari Kamera', style: TextStyle(color: Colors.blueAccent),),
                onTap: (){
                  imageFromCamera();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
    );
  }

  Future messageValidation(String title, String description){
    return Alert(
      context: context,
      type: AlertType.error,
      onWillPopActive: true,
      title: '$title',
      desc: '$description',
      style: AlertStyle(
        animationType: AnimationType.fromBottom,
        backgroundColor: Colors.white
      ),
      buttons: [
        DialogButton(
          padding: EdgeInsets.all(1),
          child: Container(
            height: 40,
            child: Center(
              child: Text('Oke', style: TextStyle(color: Colors.white, fontSize: 16),)
            ),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ]
    ).show();
  }

}