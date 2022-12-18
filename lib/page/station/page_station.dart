import 'package:flutter/material.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/widget/my_cached_image.dart';

class PageStation extends StatelessWidget {
  const PageStation({super.key, required this.station});

  final RadioStation station;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: screenSize.width,
            child: MyCachedImage(url: station.favicon),
          )
        ],
      ),
    );
  }
}
