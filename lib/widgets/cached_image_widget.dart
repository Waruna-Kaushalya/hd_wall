import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'progress_indicator_widget.dart';

class CachedImage extends StatelessWidget {
  final String imgUrl;

  const CachedImage({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  static final customeCachedManager = CacheManager(Config(
    'customeCacheKey',
    stalePeriod: const Duration(days: 2),
    maxNrOfCacheObjects: 500,
  ));
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: customeCachedManager,
      key: UniqueKey(),
      imageUrl: imgUrl,
      fit: BoxFit.fitHeight,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      fadeInDuration: const Duration(microseconds: 10),
      // fadeOutCurve: Curves.easeIn,
      placeholder: (context, url) => const Center(
        child: LinearProgressIndicatorWidgetWidget(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}
