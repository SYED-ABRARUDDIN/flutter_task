import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newstask/models/data_model.dart';


class HttpUtils{
  static Future<List<DataListModel>> fetchallnews(String countrycode) async {
    var client = http.Client();
    var tempcode=countrycode.toLowerCase();
    var apikey="4681b1b842f64d14b54010f2edff1186";

    var response_data;
    var url = "https://newsapi.org/v2/top-headlines?country=$tempcode&category=business&apiKey=$apikey";

    try {
      var response = await client.get(Uri.parse(url));
      print("${response.statusCode}");

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if(data['status']=="ok"){
          List articles=data['articles'];
              return articles.map((e) => DataListModel.fromJSON(e)).toList();
     
          

        
}else{
  return <DataListModel>[];
}
      }else{
        return <DataListModel>[];
      }
     
    } catch (e) {
      print(e);
      throw Exception(e);
     
    }
  }
}