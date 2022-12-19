import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/controller/animated_list_controller.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/page/main/cubit/stations_cubit.dart';
import 'package:my_radio_finder/page/main/widget/bottom_player.dart';
import 'package:my_radio_finder/page/main/widget/list_item.dart';
import 'package:my_radio_finder/page/main/widget/tag_selector.dart';
import 'package:my_radio_finder/util/constants.dart';
import 'package:radio_player/radio_player.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late StationsCubit _stationsCubit;
  late ScrollController _controller;
  late AnimatedListController _animatedListController;

  @override
  void initState() {
    _controller = ScrollController();
    _stationsCubit = context.read<StationsCubit>();
    _stationsCubit.fetchStations(tag: defaultTag);
    _animatedListController = AnimatedListController(listKey: listKey);
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

         if(state is StationsInitial){
           _animatedListController.clearAnimatedList();
         }else if(state is StationsSuccess){
           _animatedListController.populateAnimatedList(state.stations.length);
         }
         if(state.endReached){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No more radios stations :(')));
         }
        },
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: const TagSelector(),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Expanded(
                        child: AnimatedList(
                          padding: const EdgeInsets.only(top: kToolbarHeight),
                          key: listKey,
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
                            itemBuilder: (context, index, animation) =>
                                SlideTransition(
                                  position: animation.drive(Tween<Offset>(
                                          begin: const Offset(1, 0),
                                          end: Offset.zero)
                                      .chain(CurveTween(curve: Curves.easeIn))),
                                  child: ListItem(
                                    station: state.stations[index],
                                  ),
                                ))),
                  ],
                ),
                if (state is StationsLoading)
                  Align(
                    alignment: state.stations.isEmpty
                        ? Alignment.center
                        : Alignment.bottomCenter,
                    child: const CircularProgressIndicator(),
                  )
              ],
            ),
            bottomNavigationBar: const BottomPlayer(),
          );
        },
      ),
    );
  }
}
