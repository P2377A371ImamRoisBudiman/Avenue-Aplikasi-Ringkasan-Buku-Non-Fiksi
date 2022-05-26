import 'package:avenue/controller/api.dart';
import 'package:dio/dio.dart';
import 'package:avenue/model/model_avenue.dart';

Future<List<ModelAvenue>> fetchAvenue(List<ModelAvenue> avenue) async{
  var request = await Dio().get(ApiConstant().baseUrl+ApiConstant().api+ApiConstant().latest);
  for(Map<String, dynamic> latest in request.data){
    avenue.add(ModelAvenue(id: latest['id'],
        title: latest['title'],
        photo: latest['photo'],
        description: latest['description'],
        catId: latest['catId'],
        statusNews: latest['statusNews'],
        pdf: latest['pdf'],
        date: latest['date'],
        authorName: latest['authorName'],
        publisherName: latest['publisherName'],
        pages: latest['pages'],
        language: latest['language'],
        rating: latest['rating'],
        free: latest['free']));
  }
  return avenue;
}