import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/radio_player_cubit.dart';
import '../../../model/radio_station.dart';

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
          context.read<RadioPlayerCubit>().play(station: station);
        },
        subtitle: Text(station.tags),
        title: Text(stationName),
      ),
    );
  }
}
