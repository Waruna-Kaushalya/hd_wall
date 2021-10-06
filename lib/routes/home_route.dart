import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hd_wall/api/api.dart';
import 'package:hd_wall/widgets/image_gridview_widget.dart';
import 'package:hd_wall/widgets/progress_indicator_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeRoute extends StatefulWidget {
  static const routeName = 'home_route';
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
    imageCache!.clear();
    imageCache!.clearLiveImages();
  }

  @override
  void initState() {
    super.initState();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {});
    });
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
                        title: Text('Camera Permission'),
                        content: Text(
                            'This app needs camera access to take pictures for upload user profile photo'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Deny'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: Text('Settings'),
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
          FutureBuilder(
            future: apiManager(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != "NotConnected") {
                return StaggeredGridViewWidget(
                  snapData: snapshot.data,
                );
              } else if (snapshot.data == "NotConnected") {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 30,
                        color: Colors.red[400],
                        child: const Text(
                          "No Internet",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                    Container(
                      height: height / 3,
                    ),
                    const Icon(
                      Icons.wifi_off,
                      size: 35,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                return const CircularProgressIndicatorWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}
