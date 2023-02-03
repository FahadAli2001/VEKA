import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'bookingScreen/bookingScreenController.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> element= [];

    var data;
    Future fetchData()async{
      try {
        final response = await http.get(
          Uri.parse("https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/location"),
          headers: {
            'Consumer-Key': 'ck_35efc60387133919ea7a6e22c34a2201af711f47',
            'Consumer-Secret': 'cs_650113cb966d76d8f9f926b41f9a894186e2dcd6'
          },
        );

        if(response.statusCode == 200){
          data = json.decode(response.body);
          /*for(var i = 0 ;i < data.length ; i++){
            element.add(data.toString());

          }
          print(element.length);
          for(var item in element){
            print(item);
          }*/
        }
              }

      catch(e){
        print(e);

      }
      return data;
    }
    return  Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body:Center(
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
             /* for(var i = 0 ;i < data.length ; i++){
                element.add(data.toString());

              }*/
              for(var i = 0 ;i < data.length ; i++){
                element.add(snapshot.data[i]["title"]['rendered'].toString());
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {

                  return Column(
                    children: [
                      Text(element[index]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red,
                          width: Get.width ,
                          height: Get.height * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                                value: element[0].toString(),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,),

                                // Array list of items
                                items:element.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (val) {
                                  element[0] = val.toString();
                                }
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),

    );
  }
}
