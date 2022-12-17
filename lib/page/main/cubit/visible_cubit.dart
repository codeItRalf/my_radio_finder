import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'visible_state.dart';

class VisibleCubit extends Cubit<VisibleState> {
  VisibleCubit() : super(const VisibleInitial());

  void addStation(String id) {
    emit(VisibleUpdated(visibleStations: [
      ...{...state.visibleStations, id}
    ]));
  }

  void removeStation(String id) {
    final list = [...state.visibleStations]
      ..removeWhere((element) => element == id);
    emit(VisibleUpdated(visibleStations: list));
  }
}
