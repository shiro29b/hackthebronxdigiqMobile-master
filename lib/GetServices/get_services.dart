import 'package:digiq/MyProfileModel/singlequeuemodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../MyProfileModel/all_queues_data_model.dart';

class GetServices{

  
  Future<List<AllLines>> getAllLines()async{
    String url = "https://digiline.azurewebsites.net/api/getallqueues";
    Uri uri = Uri.parse(url);
    var req = await http.get(uri);
    // print(req.statusCode);
     //print(req.body);


    var jsonData = jsonDecode(req.body);
       //print(jsonData);
       //List<Data> result= l
      // for(var d in jsonData){
      //   Data data= Data(admin: d['admin'].toString(), city: d['city'], count: d['count'], id: d['id'], isActive: d['is_active'], name: d['name'], timePerUserM: d['time_per_user_m'], totalTime: d['total_time'], users: d['users']);
      //   print(data);
      //   result.add(data);
      //
      // }
     print(jsonData);
      //print(result);
    List<AllLines> allLinesFromJson(String str) => List<AllLines>.from(json.decode(str).map((x) => AllLines.fromJson(x)));
    return allLinesFromJson(req.body);
  }
  Future <SingleQueue> getSingleLineInfo(String id)async{
    String url = "https://digiline.azurewebsites.net/api/queueinfo";
    var data = jsonEncode({
      'queueId':id,
    });
    Uri uri = Uri.parse(url);
    var req = await http.post(uri,body:data);
    var jsonData = jsonDecode(req.body);
    if(req.statusCode!=200)
      {
        Fluttertoast.showToast(msg: jsonData["message"]);
      }
    return SingleQueue.fromJson(jsonData);
  }
}

