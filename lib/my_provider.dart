import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/api/radio_browser/repository/radio_repository.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/page/main/cubit/stations_cubit.dart';
import 'package:my_radio_finder/page/main/cubit/visible_cubit.dart';
import 'package:radio_player/radio_player.dart';

import 'my_app.dart';

class MyProvider extends StatelessWidget {
  const MyProvider({super.key});



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StationsCubit>(
            create: (context) =>
                StationsCubit(radioRepository: RadioRepository())),
        BlocProvider<VisibleCubit>(create: (context) => VisibleCubit()),
        BlocProvider<RadioPlayerCubit>(
            lazy: false, create: (context) => RadioPlayerCubit())
      ],
      child: const MyApp(),
    );
  }
}
