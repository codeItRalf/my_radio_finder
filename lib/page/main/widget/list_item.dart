import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/page/main/cubit/visible_cubit.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    required this.station,
  }) : super(key: key);

  final RadioStation station;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late VisibleCubit _visibleCubit;

  @override
  void initState() {
    _visibleCubit = context.read<VisibleCubit>();
    _visibleCubit.addStation(widget.station.stationUuid);
    super.initState();
  }

  @override
  void dispose() {
    _visibleCubit.removeStation(widget.station.stationUuid);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stationName =
        widget.station.name.isEmpty ? 'Unnamed Station' : widget.station.name;
    return ListTile(
      onTap: () {
        context.read<RadioPlayerCubit>().play(station: widget.station);
      },
      subtitle: Text(widget.station.homepage),
      title: Container(color: Colors.deepOrange, child: Text(stationName)),
    );
  }
}
