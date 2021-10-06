// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hd_wall/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

var key = dotenv.env["APIKEY"];
var url = dotenv.env["APIURL"];

// const authenticKey =
//     "Basic cHJpdmF0ZV9Yd1hjVDJKZjVIVm1KZlM3dWY4alBYRUswYWM9Og==";

// const uriHeader = "https://api.imagekit.io/v1/files";

var authenticKey = "Basic $key";

var uriHeader = url;

Future apiManager() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return "NotConnected";
  } else if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    try {
      final response = await http.get(
        Uri.parse("$uriHeader"),
        headers: {
          HttpHeaders.authorizationHeader: authenticKey,
        },
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        List<ImageModel> images = [];
        for (var u in responseJson) {
          ImageModel imag = ImageModel(u["name"], u["url"], u["thumbnail"]);
          images.add(imag);
        }

        return images;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      print("----------------");
      print(e);
      print("----------------");
    }
  }
}

class PopUpMsg extends StatelessWidget {
  const PopUpMsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Internet not connected"),
      content: const Text("Description"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
