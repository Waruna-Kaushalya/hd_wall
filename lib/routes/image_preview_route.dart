import 'package:flutter/material.dart';
import 'package:hd_wall/widgets/cached_image_widget.dart';

class ImagePreviewRoute extends StatelessWidget {
  static const routeName = '/imagepriview';
  final String image;
  final int indexNumber;

  const ImagePreviewRoute({
    Key? key,
    required this.image,
    required this.indexNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double aspect = width / height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: aspect,
              child: Hero(
                tag: "tag$indexNumber",
                child: ClipRRect(
                  child: CachedImage(imgUrl: "$image?tr=h-900"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
