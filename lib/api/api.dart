// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hd_wall/models/failer_model.dart';
import 'package:hd_wall/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

const authenticKey =
    "Basic cHJpdmF0ZV9Yd1hjVDJKZjVIVm1KZlM3dWY4alBYRUswYWM9Og==";

// const uriHeader = "https://api.imagekit.io/v1/files";
// var _key = dotenv.env["APIKEY"];
// var _url = dotenv.env["APIURL"];
// var _authenticKey = "Basic $_key";

// var uriHeader = _url;

// Future apiManager() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());

//   if (connectivityResult == ConnectivityResult.none) {
//     return "NotConnected";
//   } else if (connectivityResult == ConnectivityResult.mobile ||
//       connectivityResult == ConnectivityResult.wifi) {
//     try {
//       final response = await http.get(
//         Uri.parse("$uriHeader"),
//         headers: {
//           HttpHeaders.authorizationHeader: authenticKey,
//         },
//       );

//       if (response.statusCode == 200) {
//         var responseJson = jsonDecode(response.body);

//         List<ImageModel> images = [];
//         for (var u in responseJson) {
//           ImageModel imag = ImageModel(u["name"], u["url"], u["thumbnail"]);
//           images.add(imag);
//         }

//         return images;
//       } else {
//         throw Exception('Error');
//       }
//     } catch (e) {
//       print("----------------");
//       print(e);
//       print("----------------");
//     }
//   }
// }

class ApiManager {
  final String _baseUrl = "https://api.imagekit.io/v1/files";
  final http.Client _client;

  ApiManager({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<ImageModel>> getImages() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("connected out of scope-------------");

      try {
        final response = await _client.get(
          Uri.parse(_baseUrl),
          headers: {
            HttpHeaders.authorizationHeader: authenticKey,
          },
        );
        if (response.statusCode == 200) {
          print("connected and 200-------------");

          final data = jsonDecode(response.body) as List<dynamic>;
          List<ImageModel> images = [];
          for (var u in data) {
            ImageModel imag = ImageModel(u["name"], u['url']);
            images.add(imag);
          }
          return images;
        } else {
          throw Failure(message: "Something went wrong");
        }
      } on SocketException {
        throw "NotConnected";
      } on HttpException {
        throw Failure(message: "post not availble");
      } on FormatException {
        throw Failure(message: "format err");
      } catch (e) {
        throw Failure(message: "Something went wrong");
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      print("not connected-------------");
      throw "NotConnected";
    } else {
      throw "NotConnected";
    }
  }
// }
}
