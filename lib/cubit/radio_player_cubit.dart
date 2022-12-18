import 'dart:developer';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_player/radio_player.dart';

import '../model/radio_station.dart';

part 'radio_player_state.dart';

class RadioPlayerCubit extends Cubit<RadioPlayerState> {
  RadioPlayerCubit() : super(const RadioPlayerInitial()) {
    _init();
  }

  late final RadioPlayer _radioPlayer;

  Future<void> play({required RadioStation station}) async {
    log('url: ${station.url} resolvedUrl: ${station.urlResolved}');
    emit(RadioPlayerLoading(station: station, state: PlayerState.play));

    try {
      await _radioPlayer.setChannel(title: station.name, url: station.urlResolved);
      await _radioPlayer.play();
    } catch (error) {
      emit(RadioPlayerError(error.toString(),
          station: station, state: state.playerState));
    }
  }

  Future<void> pause() async {
    emit(RadioPlayerLoading(station: state.station, state: PlayerState.pause));
    try {
      await _radioPlayer.pause();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> stop() async {
    emit(RadioPlayerLoading(station: state.station, state: PlayerState.stop));
    try {
      await _radioPlayer.stop();
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Future<void> close() {
    _radioPlayer.stop();
    return super.close();
  }

  void _init() {
    _radioPlayer = RadioPlayer();
    _radioPlayer.stateStream.listen((event) {
      final metaData = state is RadioPlayerSuccess ? (state as RadioPlayerSuccess).metaData : <String>[];
      emit(RadioPlayerSuccess(
          station: state.station,
          state: event ? PlayerState.play : PlayerState.pause, metaData:metaData ));
    });
    _radioPlayer.metadataStream.listen((event) {
      log(event.toString());
      _radioPlayer.getArtworkImage();
      emit(RadioPlayerSuccess(
          station: state.station,
          state: state.playerState, metaData: event));
    });
  }
}
