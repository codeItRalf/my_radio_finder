import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/util/constants.dart';

import '../../../api/radio_browser/repository/radio_repository.dart';

part 'stations_state.dart';

class StationsCubit extends Cubit<StationsState> {
  final RadioRepository _radioRepository;

  StationsCubit({required RadioRepository radioRepository})
      : _radioRepository = radioRepository,
        super(const StationsInitial());

  final int _limit = 20;
  bool isBusy = false;

  Future<void> fetchStations({required String tag}) async {
    if (isBusy || (state.endReached && tag == state.tag)) return;
    isBusy = true;
    if (tag != state.tag) {
      emit(const StationsInitial());
    }
    emit(StationsLoading(stations: state.stations, tag: tag));
    try {
      final result = await _radioRepository.getStationsByTag(
          tag: tag, limit: _limit, offset: state.stations.length);
      final updatedList = [
        ...{...state.stations, ...result}
      ];
      emit(StationsSuccess(
          stations: updatedList,
          tag: tag,
          endReached: result.length != _limit));
    } catch (error) {
      emit(StationsError(error.toString(), stations: state.stations, tag: tag));
    } finally {
      isBusy = false;
    }
  }
}
