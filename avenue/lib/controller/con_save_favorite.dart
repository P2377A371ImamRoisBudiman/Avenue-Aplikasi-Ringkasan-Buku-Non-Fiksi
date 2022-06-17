import 'package:avenue/controller/api.dart';
import 'package:avenue/share_prefe.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

saveFavorite({
  required BuildContext context,
  required String idAvenue,
  required String idUser
})async{
  var data = {'id_course': idAvenue, 'id_user': idUser};
  var request = await Dio().post(ApiConstant().baseUrl+ApiConstant().saveFavorite, data: data);
  
  var checkFav = await Dio().post(ApiConstant().baseUrl+ApiConstant().checkFavorite, data: data);

  if(request.data == "success"){
    await Alert(
      context: context,
      type: AlertType.success,
      onWillPopActive: true,
      title: 'Berhasil',
      desc: 'Berhasil menambahkan ke Favorite',
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
              saveFavoriteAvanue(checkFav.data);
            },
          )
        ]
    ).show();
  }else{
    await Alert(
        context: context,
        type: AlertType.success,
        onWillPopActive: true,
        title: 'Hapus Favorite',
        desc: 'Favorite Berhasil Dihapus',
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
              saveFavoriteAvanue(checkFav.data);
            },
          )
        ]
    ).show();
  }
}