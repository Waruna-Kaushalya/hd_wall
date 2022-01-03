import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/home_route.dart';
import 'routes/image_preview_route.dart';

Future main(List<String> args) async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          primaryColor: Colors.white),
      initialRoute: HomeRoute.routeName,
      routes: {
        HomeRoute.routeName: (context) => const HomeRoute(),
        ImagePreviewRoute.routeName: (context) =>
            const ImagePreviewRoute(image: "", indexNumber: 0),
      },
    );
  }
}
