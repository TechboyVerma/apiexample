import 'dart:convert';

import 'package:apiexample/user_model.dart';
import 'package:http/http.dart' as http;


class Apiservice{
  static var client = http.Client();


  static Future<ListUserModel?> getUsers() async {
     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };

     var url = Uri.https('reqres.in','/api/users');
     var response = await client.get(url, headers: requestHeaders);

     if(response.statusCode == 200){
       var data = jsonDecode(response.body);
       return ListUserModel.fromJson(data);
     }
     else{
       return null  ;
     }


  }
}