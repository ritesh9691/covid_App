import 'dart:convert';

import 'package:corona_project/Services/utilites/app_urls.dart';
import 'package:http/http.dart' as  http;

import '../Model/WorlsStatsModel.dart';

class StatsServices{
  Future<WorlsStatsModel> fecthWorldStatsRecords()async{
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    var data;
    if(response.statusCode == 200){

       data = jsonDecode(response.body);
    print("data has loaded");
    print(data);
return WorlsStatsModel.fromJson(data);
    }else{

      print(data);
throw Exception('Error');
    }
  }
}