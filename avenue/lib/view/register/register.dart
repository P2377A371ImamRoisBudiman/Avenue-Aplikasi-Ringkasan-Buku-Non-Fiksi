import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class EbookRegister extends StatefulWidget{

  @override
  _EbookRegisterState createState() => _EbookRegisterState();
}

class _EbookRegisterState extends State<EbookRegister> {

  File _file = File('');
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Ayo Buat Akunmu Sekarang! Gratis!!', style: TextStyle(
                color: Colors.black, fontSize: 20
              ),),
              GestureDetector(
                onTap: (){
                  imagePicher(context);
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama',
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Masukkan Email',
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Masukkan Password',
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
                child: GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.only(right: 20,  left: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.4.h, right: 7.w, left: 7.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueAccent
                    ),
                    child: Text('Buat Akun', style: TextStyle(
                      color: Colors.white, fontSize: 17
                    ),),
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
                        onTap: (){},
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

  void imagePicher(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.library_add_sharp, color: Colors.blueAccent,),
                title: Text('Photo Galery', style: TextStyle(color: Colors.blueAccent),),
                onTap: (){
                  imageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blueAccent,),
                title: Text('Photo Camera', style: TextStyle(color: Colors.blueAccent),),
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

}