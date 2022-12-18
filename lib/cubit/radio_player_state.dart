part of 'radio_player_cubit.dart';


enum PlayerState{
  play,
  pause,
  stop
}

abstract class RadioPlayerState extends Equatable {
  final RadioStation station;
  final PlayerState playerState;
  const RadioPlayerState(this.station, this.playerState);

  @override
  List<Object> get props => [station];
}

class RadioPlayerInitial extends RadioPlayerState {
  const RadioPlayerInitial() : super(RadioStation.empty, PlayerState.stop);
}

class RadioPlayerLoading extends RadioPlayerState {
  const RadioPlayerLoading({required RadioStation station, required PlayerState state}) : super(station, state);
}

class RadioPlayerSuccess extends RadioPlayerState {
  const RadioPlayerSuccess({required RadioStation station, required PlayerState state}) : super(station, state);
}



class RadioPlayerError extends RadioPlayerState {
  final String error;
  const RadioPlayerError(this.error, {required RadioStation station, required PlayerState state})
      : super(station, state);
}
