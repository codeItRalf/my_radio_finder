import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_radio_finder/route_name.dart';
import 'package:my_radio_finder/util/constants.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../model/radio_station.dart';
import '../../../widget/my_cached_image.dart';
import '../../../widget/placeholder_no_image.dart';

class StationTile extends StatelessWidget {
  const StationTile({
    Key? key,
    required this.station,
  }) : super(key: key);

  final RadioStation station;

  @override
  Widget build(BuildContext context) {
    final stationName = station.name.isEmpty ? 'Unnamed Station' : station.name;
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RouteName.station, arguments: station);
        },
        leading: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(contentPadding)
          ),
            height: 56,
            width: 56,
            child: MyCachedImage(url: station.favicon)),
        subtitle: IgnorePointer(child: TextScroll(station.tags)),
        title: Row(
          children: [
            Expanded(child: IgnorePointer(child: TextScroll(stationName,selectable: false ))),
            Text('${station.bitrate}k')
          ],
        ),
      ),
    );
  }
}


