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
  Future<WorlsStatsModel> AllCountry()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryList));

    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      print("data has loaded");
      print(data);
     return WorlsStatsModel.fromJson(data);
    }else{
     // print("error $e")
      throw Exception('Error');
    }
  }
// Future<List<dynamic>> countryListApi() async{
  //   var data;
  //   final response = await http.get(Uri.parse(AppUrl.countryList));
  //   if(response.statusCode == 200){
  //
  //     data = jsonDecode(response.body);
  //     print("data has loaded");
  //     print(data);
  //     return data;
  //   }else{
  //     print(data);
  //     throw Exception('Error');
  //   }
  // }
//   // Future<WorlsStatsModel> fecthWorldStatsRecords()async{
//   List ?data;
// Future< List<dynamic>>?
//  // getData() async{
//     try{
//       final response = await http.get(Uri.parse("AppUrl.countrylist"));
//       if(response.statusCode == 200) {
//         data = json.decode(response.body);
//         print(data);
//         print("data has loaded");
//       }
//      // setState((){});
//     }catch(e){
//       print("Error: $e");
//     }
//   }
}