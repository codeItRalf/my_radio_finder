import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'placeholder_no_image.dart';

class MyCachedImage extends StatelessWidget {
  const MyCachedImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    if(url.isEmpty){
      return const PlaceHolderNoImage();
    }
    return CachedNetworkImage(
      imageUrl: url,
      errorWidget: (context, url, error) => const PlaceHolderNoImage(),
    );
  }
}
