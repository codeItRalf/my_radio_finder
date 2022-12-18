
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/page/main/cubit/visible_cubit.dart';
import 'package:my_radio_finder/page/main/widget/station_tile.dart';

class BottomPlayer extends StatelessWidget {
  const BottomPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleList = context.watch<VisibleCubit>().state.visibleStations;
    final playingStation = context.watch<RadioPlayerCubit>().state.station;

    final isVisible = visibleList.contains(playingStation.stationUuid);
    return Visibility(
      visible: playingStation != RadioStation.empty && !isVisible,
      child: StationTile(station: playingStation),
    );
  }
}
