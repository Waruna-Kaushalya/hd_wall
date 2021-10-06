import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hd_wall/api/api.dart';
import 'package:hd_wall/routes/image_preview_route.dart';
import 'package:hd_wall/widgets/progress_indicator_widget.dart';

import 'cached_image_widget.dart';

class ImageGridViewWidget extends StatefulWidget {
  const ImageGridViewWidget({Key? key}) : super(key: key);

  @override
  _ImageGridViewWidgetState createState() => _ImageGridViewWidgetState();
}

class _ImageGridViewWidgetState extends State<ImageGridViewWidget> {
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
    return FutureBuilder(
      future: ApiManager().getImages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data != "NotConnected") {
          return StaggeredGridViewWidget(
            snapData: snapshot.data,
          );
        } else if (snapshot.hasError && snapshot.error == "NotConnected") {
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
          ;
        } else {
          return const CircularProgressIndicatorWidget();
        }
      },
    );
  }
}

class StaggeredGridViewWidget extends StatelessWidget {
  final dynamic snapData;
  const StaggeredGridViewWidget({
    Key? key,
    required this.snapData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: StaggeredGridView.countBuilder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapData.length,
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Hero(
                  tag: "tag$index",
                  child: CachedImage(
                    imgUrl: "${snapData[index].imgUrl}?tr=h-300",
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewRoute(
                      image: snapData[index].imgUrl,
                      indexNumber: index,
                    ),
                  ),
                );
              },
            );
          },
          staggeredTileBuilder: (index) {
            return const StaggeredTile.count(1, 2);
          }),
    );
  }
}
