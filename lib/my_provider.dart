import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/api/radio_browser/repository/radio_repository.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/page/main/cubit/stations_cubit.dart';
import 'package:my_radio_finder/page/main/cubit/visible_cubit.dart';

import 'my_app.dart';

class MyProvider extends StatefulWidget {
  const MyProvider({super.key});

  @override
  State<MyProvider> createState() => _MyProviderState();
}

class _MyProviderState extends State<MyProvider> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StationsCubit>(
            create: (context) =>
                StationsCubit(radioRepository: RadioRepository())),
        BlocProvider<VisibleCubit>(
            create: (context) =>
                VisibleCubit()),
        BlocProvider<RadioPlayerCubit>(
            create: (context) =>
                RadioPlayerCubit())
      ],
      child: const MyApp(),
    );
  }
}
