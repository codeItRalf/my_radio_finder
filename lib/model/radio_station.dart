import 'package:equatable/equatable.dart';

class RadioStation extends Equatable {
  final String changeUuid;
  final String stationUuid;
  final String name;
  final String url;
  final String urlResolved;
  final String homepage;
  final String favicon;
  final String tags;
  final String country;
  final String countryCode;
  final String state;
  final String language;
  final String languageCodes;
  final int votes;
  final String lastChangeTime;
  final String lastChangeTimeIso8601;
  final String codec;
  final int bitrate;
  final int hls;
  final int lastCheckOk;
  final String lastCheckTime;
  final String lastCheckTimeIso8601;
  final String lastCheckOkTime;
  final String lastCheckOkTimeIso8601;
  final String lastLocalCheckTime;
  final String clickTimestamp;
  final String clickTimestampIso8601;
  final int clickCount;
  final int clickTrend;
  final int sslError;
  final bool hasExtendedInfo;

  String get getName =>  name.isEmpty ? 'Unnamed Station' : name;

  const RadioStation(
      {required this.changeUuid,
      required this.stationUuid,
      required this.name,
      required this.url,
      required this.urlResolved,
      required this.homepage,
      required this.favicon,
      required this.tags,
      required this.country,
      required this.countryCode,
      required this.state,
      required this.language,
      required this.languageCodes,
      required this.votes,
      required this.lastChangeTime,
      required this.lastChangeTimeIso8601,
      required this.codec,
      required this.bitrate,
      required this.hls,
      required this.lastCheckOk,
      required this.lastCheckTime,
      required this.lastCheckTimeIso8601,
      required this.lastCheckOkTime,
      required this.lastCheckOkTimeIso8601,
      required this.lastLocalCheckTime,
      required this.clickTimestamp,
      required this.clickTimestampIso8601,
      required this.clickCount,
      required this.clickTrend,
      required this.sslError,
      required this.hasExtendedInfo});

  static const RadioStation empty = RadioStation(
      changeUuid: '',
      stationUuid: '',
      name: '',
      url: '',
      urlResolved: '',
      homepage: '',
      favicon: '',
      tags: '',
      country: '',
      countryCode: '',
      state: '',
      language: '',
      languageCodes: '',
      votes: 0,
      lastChangeTime: '',
      lastChangeTimeIso8601: '',
      codec: '',
      bitrate: 0,
      hls: 0,
      lastCheckOk: 0,
      lastCheckTime: '',
      lastCheckTimeIso8601: '',
      lastCheckOkTime: '',
      lastCheckOkTimeIso8601: '',
      lastLocalCheckTime: '',
      clickTimestamp: '',
      clickTimestampIso8601: '',
      clickCount: 0,
      clickTrend: 0,
      sslError: 0,
      hasExtendedInfo: false);

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      changeUuid: json['changeuuid'],
      stationUuid: json['stationuuid'],
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      urlResolved: json['url_resolved'] ?? '',
      homepage: json['homepage'] ?? '',
      favicon: json['favicon'] ?? '',
      tags: json['tags'] ?? '',
      country: json['country'] ?? '',
      countryCode: json['countrycode'] ?? '',
      state: json['state'] ?? '',
      language: json['language'] ?? '',
      languageCodes: json['languagecodes'] ?? '',
      votes: json['votes'],
      lastChangeTime: json['lastchangetime'] ?? '',
      lastChangeTimeIso8601: json['lastchangetime_iso8601'] ?? '',
      codec: json['codec'] ?? '',
      bitrate: json['bitrate'],
      hls: json['hls'],
      lastCheckOk: json['lastcheckok'],
      lastCheckTime: json['lastchecktime'] ?? '',
      lastCheckTimeIso8601: json['lastchecktime_iso8601'] ?? '',
      lastCheckOkTime: json['lastcheckoktime'] ?? '',
      lastCheckOkTimeIso8601: json['lastcheckoktime_iso8601'] ?? '',
      lastLocalCheckTime: json['lastlocalchecktime'] ?? '',
      clickTimestamp: json['clicktimestamp'] ?? '',
      clickTimestampIso8601: json['clicktimestamp_iso8601'] ?? '',
      clickCount: json['clickcount'],
      clickTrend: json['clicktrend'],
      sslError: json['ssl_error'],
      hasExtendedInfo: json['has_extended_info'] ?? false,
    );
  }

  @override
  List<Object?> get props => [stationUuid];
}
