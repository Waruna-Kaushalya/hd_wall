import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hd_wall/routes/image_preview_route.dart';
import 'package:hd_wall/widgets/cached_image_widget.dart';

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
                    imgUrl: "${snapData[index].imaUrl}?tr=h-300",
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewRoute(
                      image: snapData[index].imaUrl,
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
