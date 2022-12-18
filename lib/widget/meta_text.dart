import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:text_scroll/text_scroll.dart';

import '../cubit/radio_player_cubit.dart';

class MetaText extends StatelessWidget {
  final RadioStation station;
  const MetaText({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioPlayerCubit, RadioPlayerState>(
      builder: (context, state) {
        if (state.station == station && state is RadioPlayerSuccess && state.metaData.isNotEmpty) {
          return IgnorePointer(
            child: TextScroll(state.metaData.join(' ')),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
