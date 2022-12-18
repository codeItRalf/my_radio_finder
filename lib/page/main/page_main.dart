import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/page/main/cubit/stations_cubit.dart';
import 'package:my_radio_finder/page/main/widget/bottom_player.dart';
import 'package:my_radio_finder/page/main/widget/list_item.dart';
import 'package:my_radio_finder/page/main/widget/tag_selector.dart';
import 'package:my_radio_finder/util/constants.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  late StationsCubit _stationsCubit;
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _stationsCubit = context.read<StationsCubit>();
    _stationsCubit.fetchStations(tag: defaultTag);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<StationsCubit, StationsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            appBar: const TagSelector(),
            body: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        controller: _controller
                          ..addListener(() {
                            if (state is! StationsLoading) {
                              if (_controller.offset >=
                                  _controller.position.maxScrollExtent) {
                                _stationsCubit.fetchStations(
                                    tag: _stationsCubit.state.tag);
                              }
                            }
                          }),
                        itemCount: state.stations.length,
                        itemBuilder: (context, index) => ListItem(
                              station: state.stations[index],
                            ))),
              ],
            ),
            bottomNavigationBar: const BottomPlayer(),
          );
        },
      ),
    );
  }
}

