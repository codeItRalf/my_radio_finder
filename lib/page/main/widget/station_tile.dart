import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/route_name.dart';
import 'package:my_radio_finder/util/constants.dart';
import 'package:my_radio_finder/widget/meta_text.dart';
import 'package:my_radio_finder/widget/play_pause_button.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../model/radio_station.dart';
import '../../../widget/my_cached_image.dart';

class StationTile extends StatelessWidget {
  const StationTile({
    Key? key,
    required this.station,
  }) : super(key: key);

  final RadioStation station;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        context.watch<RadioPlayerCubit>().state.station == station;
    final theme = Theme.of(context);
    return Card(
      elevation: isSelected ? 2.0 : null,
      shadowColor: isSelected ? theme.colorScheme.primary : null,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RouteName.station, arguments: station);
        },
        leading: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(contentPadding)),
            height: 56,
            width: 56,
            child: Stack(children: [
              MyCachedImage(url: station.favicon),
              Align(
                  alignment: Alignment.center,
                  child: PlayPauseButton(station: station))
            ])),
        subtitle: IgnorePointer(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (station.tags.isNotEmpty) TextScroll(station.tags),
            MetaText(
              station: station,
            )
          ],
        )),
        title: Row(
          children: [
            Expanded(
                child: IgnorePointer(
                    child: TextScroll(station.getName, selectable: false))),
            Text('${station.bitrate}k')
          ],
        ),
      ),
    );
  }
}
