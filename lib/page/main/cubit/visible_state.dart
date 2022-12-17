part of 'visible_cubit.dart';

abstract class VisibleState extends Equatable {
  const VisibleState(this.visibleStations);
  final List<String> visibleStations;
  @override
  List<Object> get props => visibleStations;
}

class VisibleInitial extends VisibleState {
  const VisibleInitial() : super(const []);
}

class VisibleUpdated extends VisibleState {
  const VisibleUpdated({required List<String> visibleStations}) : super(visibleStations);
}
