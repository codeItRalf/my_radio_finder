import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/page/main/cubit/stations_cubit.dart';
import 'package:my_radio_finder/util/constants.dart';
import 'package:my_radio_finder/util/extensions.dart';

class TagSelector extends StatefulWidget implements PreferredSizeWidget {
  const TagSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<TagSelector> createState() => _TagSelectorState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TagSelectorState extends State<TagSelector> {
  late StationsCubit _cubit;

  final tags = [
    defaultTag,
    '80s',
    'rock',
    'pop',
    'electronic',
    'disco',
    'jazz',
    'classical',
    'reggaeton',
    'metal',
    'techno'
  ];

  @override
  void initState() {
    _cubit = context.read<StationsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tag = context.watch<StationsCubit>().state.tag;
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: contentPadding)
          .copyWith(left: contentPadding),
      scrollDirection: Axis.horizontal,
      children: tags
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: contentPadding / 2),
                child: ElevatedButton(
                    onPressed: tag == e
                        ? null
                        : () {
                            _cubit.fetchStations(tag: e);
                          },
                    child: Text(e.capitalize())),
              ))
          .toList(),
    );
  }
}
