import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/page/station/widget/play_pause_button.dart';
import 'package:my_radio_finder/util/constants.dart';
import 'package:my_radio_finder/widget/my_cached_image.dart';
import 'package:radio_player/radio_player.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../widget/meta_text.dart';

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
            child: StationImage(station: station),
          ),
          Padding(
            padding: const EdgeInsets.all(contentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextScroll(
                  station.getName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (station.tags.isNotEmpty)
                  TextScroll(
                    station.tags,
                  ),
                if (station.homepage.isNotEmpty) Text(station.homepage),
                MetaText(
                  station: station,
                ),
                PlayPauseButton(
                  station: station,
                )
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: contentPadding),
                        child: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class StationImage extends StatelessWidget {
  const StationImage({
    Key? key,
    required this.station,
  }) : super(key: key);

  final RadioStation station;

  @override
  Widget build(BuildContext context) {
    final radioPlayerCubit = context.watch<RadioPlayerCubit>();
    final radioState = radioPlayerCubit.state;
    ImageProvider? imageProvider;
    if (radioState is RadioPlayerSuccess && radioState.imageProvider != null) {
      return Image(image: imageProvider!);
    } else {
      return MyCachedImage(url: station.favicon);
    }
  }
}
