import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    if(state is RadioPlayerSuccess){
    await  _radioPlayer.stop();
    }

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
    if(state is RadioPlayerLoading){

    }
    emit(RadioPlayerLoading(station: state.station, state: PlayerState.pause));
    try {
      await _radioPlayer.pause();
    } catch (error) {
      log(error.toString());
    }
  }


  @override
  Future<void> close() async {
    await _radioPlayer.stop();
    return super.close();
  }

  void _init() {
    _radioPlayer = RadioPlayer();
    _radioPlayer.stateStream.listen((event) async {
      if(event && state is RadioPlayerLoading && state.playerState == PlayerState.pause){
        await _radioPlayer.stop();
      }else{
        final metaData = state is RadioPlayerSuccess ? (state as RadioPlayerSuccess).metaData : <String>[];
        emit(RadioPlayerSuccess(
            station: state.station,
            state: event ? PlayerState.play : PlayerState.pause, metaData:metaData ));
      }
    });
    _radioPlayer.metadataStream.listen((event) async {
      Image? image;
      try{
        image = await _radioPlayer.getArtworkImage();
        log('image is null : ${image == null}');
      }catch(error){
        log('getArtworkImage exception ${error.toString()}');
      }
      final imageProvider = image?.image;
      emit(RadioPlayerSuccess(
          imageProvider: imageProvider,
          station: state.station,
          state: state.playerState, metaData: event));
    });
  }
}
