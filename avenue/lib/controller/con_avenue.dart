import 'package:dio/dio.dart';
import 'package:avenue/controller/api.dart';
import 'package:avenue/model/model_avenue.dart';

Future<List<ModelAvenue>> fetchAvenue(List<ModelAvenue> ebook) async {
  var request = await Dio()
      .get(ApiConstant().baseUrl + ApiConstant().api + ApiConstant().slide);
  for (Map<String, dynamic> latest in request.data) {
    ebook.add(ModelAvenue(
        id: latest['id'],
        title: latest['title'],
        photo: latest['photo'],
        description: latest['description'],
        catId: latest['cat_id'],
        statusNews: latest['status_news'],
        pdf: latest['pdf'],
        date: latest['date'],
        authorName: latest['author_name'],
        publisherName: latest['publisher_name'],
        pages: latest['pages'],
        language: latest['language'],
        rating: latest['rating'],
        free: latest['free']));
  }
  return ebook;
}
