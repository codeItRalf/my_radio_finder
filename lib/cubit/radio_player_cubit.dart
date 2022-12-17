import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/radio_station.dart';

part 'radio_player_state.dart';

class RadioPlayerCubit extends Cubit<RadioPlayerState> {
  RadioPlayerCubit() : super(const RadioPlayerInitial());


  void play({required RadioStation station}){
    emit(RadioPlayerPlay(station: station));
  }

}
