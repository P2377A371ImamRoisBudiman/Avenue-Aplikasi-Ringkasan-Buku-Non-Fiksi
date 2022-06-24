import 'package:avenue/controller/con_category.dart';
import 'package:avenue/controller/con_latest.dart';
import 'package:avenue/model/model_category.dart';
import 'package:avenue/routers.dart';
import 'package:avenue/share_prefe.dart';
import 'package:avenue/view/ebook_by_cat/avenue_by_cat.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avenue/controller/con_avenue.dart';
import 'package:avenue/model/model_avenue.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';

import '../../controller/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //SSLIDER
  Future<List<ModelAvenue>>? getSlider;
  List<ModelAvenue> listSlider = [];
  //LATEST
  Future<List<ModelAvenue>>? getPostTerbaru;
  List<ModelAvenue> listPostTerbaru = [];
  //COMING SOON
  Future<List<ModelAvenue>>? getComing;
  List<ModelAvenue> listComing = [];

  //CATEGORY
  Future<List<ModelCategory>>? getCategory;
  List<ModelCategory> listCategory = [];

  String id = '', name = '', email = '', photo = '';

  @override
  void initState() {
    super.initState();
    getSlider = fetchAvenue(listSlider);
    getPostTerbaru = fetchLatest(listPostTerbaru);
    getComing = fetchAvenue(listComing);
    getCategory = fetchCategory(listCategory);
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        photo = value[3];
        getPhoto(id);
      });
    });
  }

  Future getPhoto(String idUser) async {
    var request = await Dio().post(
        ApiConstant().baseUrl + ApiConstant().viewPhoto,
        data: {'id': idUser});
    var decode = request.data;
    if (decode != "no_img") {
      setState(() {
        photo = decode;
      });
    } else {
      setState(() {
        photo = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        title: Row(
          children: [
            Container(
                child: photo == ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/image/resgister.png',
                          fit: BoxFit.cover,
                          width: 12.w,
                          height: 6.h,
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.network(
                          '$photo',
                          fit: BoxFit.cover,
                          width: 12.w,
                          height: 6.h,
                        ),
                      )),
            SizedBox(
              width: 2.w,
            ),
            Text(
              '$name',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: FutureBuilder(
          future: getSlider,
          builder: (BuildContext context,
              AsyncSnapshot<List<ModelAvenue>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SLIDER
                  Container(
                    child: FutureBuilder(
                      future: getSlider,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ModelAvenue>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            height: 27.h,
                            child: Swiper(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              child: Image.network(
                                                listSlider[index].photo,
                                                width: 100,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                    ),
                                                    gradient: LinearGradient(
                                                        end: Alignment(0.0, -1),
                                                        begin:
                                                            Alignment(0.0, 0.2),
                                                        colors: [
                                                          Colors.blue,
                                                          Colors.black
                                                              .withOpacity(0.1)
                                                        ])),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    listSlider[index].title,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  //ITEM TERBARU
                  Container(
                    child: FutureBuilder(
                      future: getPostTerbaru,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ModelAvenue>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Latest',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                                child: ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(
                                        "persamaanIndex $index dan ${snapshot.data!.length}");
                                    if (index == snapshot.data!.length) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 25.w,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            'Lihat Semua',
                                            style:
                                                TextStyle(color: Colors.blue),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    } else {
                                      //ITEM BUKU
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                child: Image.network(
                                                  listPostTerbaru[index].photo,
                                                  height: 15.h,
                                                  width: 25.w,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Container(
                                                width: 25.w,
                                                child: Text(
                                                  listPostTerbaru[index].title,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  //COMING SOON
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: getComing,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ModelAvenue>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            color: Colors.blueGrey.withOpacity(0.5),
                            padding: EdgeInsets.only(top: 2.0.h),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Segera Hadir',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        letterSpacing: 10,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(top: 3.h),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          child: Column(
                                            children: [],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  //CATEGORY
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: getCategory,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ModelCategory>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: ListView.builder(
                                  itemBuilder: (BuildContext cxt, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        pushPage(
                                            context,
                                            AvenueByCategory(
                                              idCategory:
                                                  listCategory[index].catId,
                                            ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              child: Image.network(
                                                listCategory[index].photoCat,
                                                height: 15.h,
                                                width: 25.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            ClipRRect(
                                                child: Container(
                                              height: 15.h,
                                              width: 25.w,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                            )),
                                            Positioned(
                                              child: Center(
                                                child: Text(
                                                  listCategory[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              bottom: 0,
                                              top: 0,
                                              right: 0,
                                              left: 0,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  //JARAK
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              );
            }
          },
        )),
      ),
    );
  }
}
