import 'package:flutter/material.dart';


class PlaceHolderNoImage extends StatelessWidget {
  const PlaceHolderNoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
      child: const Center(
        child: Opacity(opacity: .5,
            child: Icon(Icons.image_not_supported_outlined)),
      ),
    );
  }
}
