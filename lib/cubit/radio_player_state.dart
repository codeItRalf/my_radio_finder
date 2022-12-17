part of 'radio_player_cubit.dart';

abstract class RadioPlayerState extends Equatable {
  final RadioStation station;
  const RadioPlayerState(this.station);

  @override
  List<Object> get props => [station];
}

class RadioPlayerInitial extends RadioPlayerState {
  const RadioPlayerInitial() : super(RadioStation.empty);
}

class RadioPlayerPlay extends RadioPlayerState {
  const RadioPlayerPlay({required RadioStation station}) : super(station);
}
