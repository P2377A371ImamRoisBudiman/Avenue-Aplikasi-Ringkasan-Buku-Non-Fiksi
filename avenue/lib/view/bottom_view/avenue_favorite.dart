import 'package:avenue/controller/con_favorite.dart';
import 'package:avenue/model/model_avenue.dart';
import 'package:avenue/routers.dart';
import 'package:avenue/share_prefe.dart';
import 'package:avenue/view/detail/avenue_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AvenueFavorite extends StatefulWidget {
  const AvenueFavorite({Key? key}) : super(key: key);

  @override
  State<AvenueFavorite> createState() => _AvenueFavoriteState();
}

class _AvenueFavoriteState extends State<AvenueFavorite> {

  Future<List<ModelAvenue>>? getFavorite;
  List<ModelAvenue> ListFavorite = [];

  String id = "", name = "", email = "", photo = "";

  @override
  void initState() {
    super.initState();
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getFavorite = fetchFavorite(ListFavorite, id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Favoorite', style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: getFavorite,
            builder: (BuildContext context, AsyncSnapshot<List<ModelAvenue>> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 5.5 / 9.0
                  ), itemBuilder: (BuildContext context, int index) { 
                    return GestureDetector(
                      onTap: (){
                        pushPage(context, AvenueDetail(
                            avenueId: ListFavorite[index].id,
                            status: ListFavorite[index].statusNews));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                '${ListFavorite[index].photo}', height: 20.h, width: 30.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 1.w,),
                            Container(
                              child: Text('${ListFavorite[index].title}', style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500
                              ),maxLines: 2, overflow: TextOverflow.ellipsis,),
                              width: 30.w,
                            )
                          ],
                        ),
                      ),
                    );
                },
                );
              }else{
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
