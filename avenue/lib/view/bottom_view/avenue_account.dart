import 'dart:io';

import 'package:avenue/controller/api.dart';
import 'package:avenue/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../share_prefe.dart';
import '../login/login.dart';


class AvenueAccount extends StatefulWidget {
  const AvenueAccount({Key? key}) : super(key: key);

  @override
  State<AvenueAccount> createState() => _AvenueAccountState();
}

class _AvenueAccountState extends State<AvenueAccount> {

  String photoUser = '';
  File file = File('');
  final picker = ImagePicker();
  String id = "", name = "", email = "";
  late SharedPreferences preferences;

  Future updatePhotoProfile() async{
    var req = http.MultipartRequest('POST', Uri.parse(ApiConstant().baseUrl+ApiConstant().updatePhoto));
    req.fields['idUser'] = id;
    var photo = await http.MultipartFile.fromPath('photo', file.path);
    req.files.add(photo);
    var response = await req.send();
    if(response.statusCode == 200){
      setState(() {
        file = File('');
      });
      getPhoto(id);
    }
  }

  Future getPhoto(String idUser) async{
    var request = await Dio().post(ApiConstant().baseUrl + ApiConstant().viewPhoto, data: {'id': idUser});
    var decode = request.data;
    if(decode != "no_img"){
      setState(() {
        photoUser = decode;
      });
    }else{
      setState(() {
        photoUser = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getPhoto(id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500
        ),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              updatePhotoProfile();
            },
            child: file.path != '' ? Center(
              child: Text('Simpan', style: TextStyle(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500
              ),),
            ) : Text(''),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    imagePicker(context);
                  },
                  child: Container(
                    height: 15.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        photoUser != '' ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network('$photoUser', fit: BoxFit.cover, width: 30.w, height: 30.h,),
                        ) : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/image/register.png', fit: BoxFit.cover, width: 30.w, height: 30.h,),
                        ),
                        file.path == '' ? Text('') : Text('Ubah Foto ->', style: TextStyle(
                          color: Colors.black,
                        ),),
                        file.path == '' ? Text('') : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: file.path == '' ? Image.asset('assets/images/register.png',
                            width: 30.w, height: 30.h, fit: BoxFit.cover,) : Image.file(
                            file, width: 30.w, height: 30.h, fit: BoxFit.cover,
                          )
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.sp),
                  child: Text(name, style: TextStyle(
                      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500
                  ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.email_outlined, color: Colors.red,),
                    SizedBox(width: 15,),
                    Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      child: Text(email, style: TextStyle(
                          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500
                      ),),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 30.sp),
                    child: Text('Avenue App Support', style: TextStyle(
                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15.sp),
                      child: Text('Tentang App', style: TextStyle(
                          color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      child: Text('Kebijakan Privasi', style: TextStyle(
                          color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      child: Text('Beri Rating', style: TextStyle(
                          color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      child: Text('Bagikan Aplikasi', style: TextStyle(
                          color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    preferences = await SharedPreferences.getInstance();
                    preferences.remove('login');
                    pushPageRemove(context, Login());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                    child: Text('Keluar', style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  imageFromGallery()async{
    var imageGallery = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(imageGallery != null){
        file = File(imageGallery.path);
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
        file = File(imageCamera.path);
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

}
