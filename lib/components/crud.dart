// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class Crud{
//    getRequest(String url) async{
//      try{
//        var response = await http.get(Uri.parse(url));
//        if(response.statusCode == 200){
//          var responseBody = jsonDecode(response.body);
//          return responseBody;
//        }else{
//          print("ERORRRRRRRRRRRRRRRRRRRRRRRRRRR${response.statusCode}:");
//        }
//      }catch(e){
//        print("Error Catch: $e");
//
//      }
//    }
//    postRequest(String url, Map data) async{
//      try{
//        var response = await http.post(Uri.parse(url), body: data);
//        if(response.statusCode == 200){
//          var responseBody = jsonDecode(response.body);
//          return responseBody;
//        }else{
//          print("ERORRRRRRRRRRRRRRRRRRRRRRRRRRR${response.statusCode}:");
//        }
//      }catch(e){
//        print("Error Catch: $e");
//
//      }
//    }
// }
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'wael:wael12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};
mixin class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("Success ${response.statusCode}");
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var mutlpartFile = http.MultipartFile("file", stream, length,
        filename: file.path);
    request.headers.addAll(myheaders);
    request.files.add(mutlpartFile);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Errorr${myRequest.statusCode}");
    }
  }  // postRequestWithFile(String url, Map data, File file) async {
  //   var request = http.MultipartRequest("POST", Uri.parse(url));
  //   var length = await file.length();
  //   var stream = http.ByteStream(file.openRead());
  //   var mutlpartFile = http.MultipartFile("file", stream, length,
  //       filename: basename(file.path));
  //
  //   ///هنا بدي احمل الملف على الريكويست الي رايح عالسيرفر
  //   request.files.add(mutlpartFile);
  //
  //   ///عشان ارسل الداتا مع الملاحظة مع الملف
  //   data.forEach((key, value) {
  //     request.fields[key] = value;
  //   });
  //   var myRequest = await request.send();
  //   var response = await http.Response.fromStream(myRequest);
  //   if (myRequest.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     print("Errorrrrrrrrrrrrr ${myRequest.statusCode}");
  //   }
  // }

  getRequestt(String url)async{
    try{
     var response = await http.get(Uri.parse(url));
     if(response.statusCode == 200)
     {
       /// jsonDecode بتحول json To dart
       var responsebody = jsonDecode(response.body);
       return responsebody;
     }else{
       print("Error ${response.statusCode}");
     }
    }catch(e){
      print("Error Catch $e");
    }
  }

}
