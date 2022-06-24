import 'package:avenue/controller/con_by_cat.dart';
import 'package:avenue/controller/con_latest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/model_avenue.dart';
import '../../routers.dart';
import '../detail/avenue_detail.dart';

class AvenueByCategory extends StatefulWidget {
  int idCategory;
  AvenueByCategory({required this.idCategory});

  @override
  State<AvenueByCategory> createState() => _AvenueByCategory();
}

class _AvenueByCategory extends State<AvenueByCategory> {
  Future<List<ModelAvenue>>? getLibrary;
  List<ModelAvenue> listLibrary = [];

  @override
  void initState() {
    getLibrary = fetchByCategory(listLibrary, widget.idCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Ebook By Category',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: getLibrary,
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelAvenue>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 5.5 / 9.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        pushPage(
                            context,
                            AvenueDetail(
                                avenueId: listLibrary[index].id,
                                status: listLibrary[index].statusNews));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                '${listLibrary[index].photo}',
                                height: 20.h,
                                width: 30.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Container(
                              child: Text(
                                '${listLibrary[index].title}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              width: 30.w,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
