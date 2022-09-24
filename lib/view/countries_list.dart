import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Services/states_services.dart';
class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  List<dynamic>? data ;
  @override
  void initState() {
    super.initState();
   getData();
  }

  getData() async{
    try{
      final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
      data = json.decode(response.body);
      print(data);
      setState(() {});
    } catch (e){
      print("Error: $e");
    }
  }

  TextEditingController searchControtter = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
   // StatsServices statsServices = StatsServices();


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (_){
                  setState(() {

                  });
                },
                controller: searchControtter,
                decoration: InputDecoration(
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
              child: data!= null?
                  ListView.builder(
                    itemCount: data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){

                      return data![index]["country"].toString().toLowerCase().startsWith(
                        searchControtter.text.toLowerCase()
                      )?
                        Row(
                          children: [
                            Image.network(data![index]["countryInfo"]["flag"]),
                            Text(data![index]["country"]),
                          ],
                        ):Container();
                      
                    },
                  )
              : Center(child: CircularProgressIndicator())
              ,

                // child: FutureBuilder(
                //   future: getData(),
                //   builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                //     if (!snapshot.hasData) {
                //       return Text('loading');
                //     }else{
                //       return ListView.builder(itemBuilder: (context, index){
                //         return Column(
                //           children: [
                //
                //                       Text("hello")
                //
                //           ],
                //         );
                //       }
                //
                //       );
                //     }
                //   }
                // ),
            ),
          ],
        ),
      ),

    );
  }
}
