import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hd_wall/models/image_model.dart';
import 'package:hd_wall/widgets/image_gridview_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeRoute extends StatefulWidget {
  static const routeName = 'home_route';
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  late Future<List<ImageModel>> _futureImages;
  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
    imageCache!.clear();
    imageCache!.clearLiveImages();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HDWall"),
        actions: [
          TextButton(
            onPressed: () async {
              clearCache();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Camera Permission'),
                        content: const Text(
                            'This app needs camera access to take pictures for upload user profile photo'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Deny'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: const Text('Settings'),
                            onPressed: () => openAppSettings(),
                          ),
                        ],
                      ));
            },
            child: const Text(
              "Clear Cache",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Builder(builder: (context) {
            return const ImageGridViewWidget();
          }),
        ],
      ),
    );
  }
}
