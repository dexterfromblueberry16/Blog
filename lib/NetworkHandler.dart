import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  // String baseurl = "http://10.0.2.2:5000";

  String baseurl = "https://blog-server3.vercel.app";

  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    print(url);
    // /user/register
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Allow-Control-Allow-Origin": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    print(token);
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer ${token}",
        "Allow-Control-Allow-Origin": "*",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patchBlog(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> postLikes(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(url);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      // body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> deleteLikes(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(url);
    var response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      // body: json.encode(body),
    );
    return response;
  }

  // Future getLikedOrNot(String url) async {
  //   String token = await storage.read(key: "token");
  //   url = formater(url);
  //   print(url);
  //   // /user/register
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       "Authorization": "Bearer $token",
  //       "Allow-Control-Allow-Origin": "*",
  //     },
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     log.i(response.body);

  //     return json.decode(response.body);
  //   }
  //   log.i(response.body);
  //   log.i(response.statusCode);
  // }

  // Future updateLikedOrNot(String url, var body) async {
  //   String token = await storage.read(key: "token");
  //   url = formater(url);
  //   print(url);
  //   // /user/register
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Authorization": "Bearer $token",
  //       "Allow-Control-Allow-Origin": "*",
  //     },
  //     body: json.encode(body),
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     log.i(response.body);

  //     return json.decode(response.body);
  //   }
  //   log.i(response.body);
  //   log.i(response.statusCode);
  // }

  Map<String, String> data = {"like": ""};

  Future getLikes(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    print(url);
    // /user/register
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Allow-Control-Allow-Origin": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post1(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> delete(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(url);
    log.d(body);
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    print("filepath : $filepath");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));

    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    log.i(response);

    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads/$imageName.jpg");
    return NetworkImage(url);
  }
}
