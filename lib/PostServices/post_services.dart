import 'package:digiq/MyProfileModel/profilemodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class PostServices{

  Future <dynamic> ApiSignUpdata(String username,String password,String phone) async {
    var url = 'https://digiline.azurewebsites.net/api/signup';
    Uri uri = Uri.parse(url);
    var data = jsonEncode({
      "username":username,
      "password":password,
      "phone":phone,
    });
    var req = await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", username);
    prefs.setString("password", password);
    var result = jsonDecode(req.body);
    return result['message'];

    /*var url = 'https://digiline.azurewebsites.net/getallusers';
    Uri uri = Uri.parse(url);
    var req = await http.get(uri);
    print(req.statusCode);*/

  }

  Future <dynamic> ApiLogIn(String username,String password) async {
    var url = 'https://digiline.azurewebsites.net/api/login';
    Uri uri = Uri.parse(url);
    var data = jsonEncode({
      "username": username,
      "password":password
    });
    var req = await http.post(uri,body: data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", username);
    print(req.statusCode);
    print(req.body);
    var result = jsonDecode(req.body);
    return result['message'];

  }


  Future <dynamic> ApiJoinLine (String username,String qId)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usname = prefs.getString("name");
    var url = 'https://digiline.azurewebsites.net/api/joinqueue';
    Uri uri = Uri.parse(url);
    var data= jsonEncode({
      'username':usname,
      'queueId': qId,
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    var result = jsonDecode(req.body);
    return result['message'];
  }
  Future <MyProfile> getJoinedLines (String username,String qId)async {
    var url = 'https://digiline.azurewebsites.net/api/getuserinfo';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usname = prefs.getString("name");
    print("this namw: $usname");
    Uri uri = Uri.parse(url);
    var data= jsonEncode({
      'username':usname,
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    var result = jsonDecode(req.body);
    MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));
    //String myProfileToJson(MyProfile data) => json.encode(data.toJson());
    return myProfileFromJson(req.body);
  }
  Future <dynamic> deactivateLine (String username,String qId)async {
    var url = 'https://digiline.azurewebsites.net/api/deactivatequeue';
    Uri uri = Uri.parse(url);
    var data= jsonEncode({
      'queueId':qId,
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    if(req.statusCode==200) {

      return true;
    }
    return false;
  }
  Future <dynamic> activateLine (String username,String qId)async {
    var url = 'https://digiline.azurewebsites.net/api/activatequeue';
    Uri uri = Uri.parse(url);
    var data= jsonEncode({
      'queueId':qId,
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    if(req.statusCode==200) {

      return true;
    }
    return false;
  }
  Future <dynamic> deleteLine (String username,String qId)async {
    var url = 'https://digiline.azurewebsites.net/api/deletequeue';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usname = prefs.getString("name");
    Uri uri = Uri.parse(url);
    var data= jsonEncode({
      'queueId':qId,
      'username':usname
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    if(req.statusCode==200) {
      return true;
    }
    return false;
  }
  Future <dynamic> goNext (String username,String qId)async {
    var url = 'https://digiline.azurewebsites.net/api/gonext';
    Uri uri = Uri.parse(url);
    var data= jsonEncode({
      'queueId':qId,
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    if(req.statusCode==200) {
      return true;
    }
    return false;
  }
  Future <dynamic> leaveQ (String username,String qId)async {
    var url = "https://digiline.azurewebsites.net/api/leavequeue";
    Uri uri = Uri.parse(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usname = prefs.getString("name");
    var data= jsonEncode({
      'queueId':qId,
      'username':usname,
    });
    var req =await http.post(uri,body: data);
    print(req.statusCode);
    print(req.body);
    var result = jsonDecode(req.body);
    print(result);
    return true;
  }
  Future<dynamic> createLine(String userName, String name, int time, String city, String tag)async{
    String url = "https://digiline.azurewebsites.net/api/createqueue";
    // int id = int.parse(idx.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("IN FUnction: $name $time $city $tag");
    String? usname = prefs.getString("name");
    var data = jsonEncode({
      "username":usname,
      "name":name,
      "time":time,
      "city":city,
      "tag":tag
    });
    /* var head ={
      "Content-Type":"application/json"
    };*/
    Uri uri = Uri.parse(url);
    var req = await http.post(uri,body:data);
    print(req.statusCode);
    print(req.body);
    if(req.statusCode==201) {
      var jsonData = jsonDecode(req.body);
      return jsonData["queueId"];
    }
    return false;
  }
}
