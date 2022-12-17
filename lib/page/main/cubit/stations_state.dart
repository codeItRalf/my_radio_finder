part of 'stations_cubit.dart';

abstract class StationsState extends Equatable {
  const StationsState(this.stations, this.tag, this.endReached);
  final List<RadioStation> stations;
  final String tag;
  final bool endReached;
  @override
  List<Object> get props => [stations, tag, endReached];
}

class StationsInitial extends StationsState {
  const StationsInitial() : super(const [], defaultTag, false);
}

class StationsLoading extends StationsState {
  const StationsLoading({required List<RadioStation> stations, required String tag}) : super(stations, tag, false);
}

class StationsSuccess extends StationsState {
  const StationsSuccess({required List<RadioStation> stations, required String tag, required bool endReached}) : super(stations, tag, endReached);
}
class StationsError extends StationsState {
  final String error;
  const StationsError(this.error, {required List<RadioStation> stations, required String tag}) : super(stations, tag, false);
}
