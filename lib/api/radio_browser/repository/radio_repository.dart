import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_radio_finder/api/client.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/util/constants.dart';

class RadioRepository {
  static final RadioRepository _repository = RadioRepository._();

  RadioRepository._();

  factory RadioRepository() {
    return _repository;
  }

  Future<List<RadioStation>> getStationsByTag(
      {required String tag, required int limit, required int offset}) async {
    final queryParams = {
      'limit': limit,
      'offset': offset,
    };

    try {
      final result = await fetch(
          'stations/bytag/${tag == defaultTag ? '' : tag}',
          Method.get,
          _getOptions(),
          queryParams: queryParams);
      return [...result.map((e) => RadioStation.fromJson(e))];
    } catch (e) {
      log('Future<List<RadioStation>> getStationsByTag EXCEPTION : ${e.toString()}');
      rethrow;
    }
  }

  BaseOptions _getOptions() {
    var headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      HttpHeaders.acceptHeader: Headers.jsonContentType,
    };
    return BaseOptions(
        baseUrl: 'http://at1.api.radio-browser.info/json/',
        headers: headers,
        connectTimeout: 20000);
  }
}
