import 'package:avenue/controller/con_detail.dart';
import 'package:avenue/model/model_avenue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

class AvenueDetail extends StatefulWidget {
  int avenueId;
  int status;

  AvenueDetail({required this.avenueId, required this.status});
  @override
  _AvenueDetailState createState() => _AvenueDetailState();
}

class _AvenueDetailState extends State<AvenueDetail> {
  Future<List<ModelAvenue>>? getDetail;
  List<ModelAvenue> listDetail = [];

  @override
  void initState() {
    super.initState();

    getDetail = fetchDetail(listDetail, widget.avenueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
          future: getDetail,
          builder: (BuildContext context,
              AsyncSnapshot<List<ModelAvenue>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 25.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image.network(
                                      '${listDetail[index].photo}',
                                      fit: BoxFit.cover,
                                      width: 35.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          '\${listDetail[index].title}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          '\${listDetail[index].authorName}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          'Publiser : \${listDetail[index].publisherName}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child:
                                                  Icon(Icons.bookmark_border),
                                            ),
                                            SizedBox(
                                              width: 1.5.w,
                                            ),
                                            Text(
                                                '${listDetail[index].pages} Pages',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            SizedBox(
                                              width: 1.5.w,
                                            ),
                                            listDetail[index].free == 1
                                                ? Text('Free',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis)
                                                : Text('Premium',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                _share();
                                              },
                                              child: Icon(
                                                Icons.share,
                                                color: Colors.black,
                                                size: 21.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                          ],
                                        )
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            widget.status == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.blue),
                                    child: Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        'Segera Hadir',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.only(left: 12, right: 12),
                                  )
                                : listDetail[index].free == 1
                                    ? GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.blue),
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              'Baca (GRATIS)',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12),
                                        ),
                                        onTap: () {},
                                      )
                                    : GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.blue),
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              'Baca (BERBAYAR)',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12),
                                        ),
                                        onTap: () {},
                                      ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 2.h),
                              margin: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.blue),
                              child: Column(
                                children: [
                                  Text(
                                    'Deskripsi',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Html(
                                    data: '${listDetail[index].description}',
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            )
                          ],
                        );
                      }),
                ],
              );
            } else {
              return Align(
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Colors.blueAccent,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _share() async {
    PackageInfo pi = await PackageInfo.fromPlatform();
    Share.share(
        "Saya Membaca buku bagus sekali di Aplikasi ${pi.appName} '\n' Download sekarang di https://play.google.com/store/apps/details?id=${pi.packageName}");
  }
}
