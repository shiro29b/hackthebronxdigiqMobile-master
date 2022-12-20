import 'dart:convert';
import 'package:http/http.dart' as http;
class GetService
{
  Future<dynamic> getJoinedLines()async{
    String url = "https://shubbhuprasu.azurewebsites.net/getAll";
    Uri uri = Uri.parse(url);
    var req = await http.get(uri);
    print(req.statusCode);
    print(req.body);
    if(req.statusCode==200) {
      return jsonDecode(req.body);
    }
    return "No Data Found";
  }
}