import 'dart:convert';

import 'package:flutter/foundation.dart';

class TruckDetails {
  final String titleText;
  final String startStation;
  final String departureTime;
  final String truckNumber;
  final String runby;
  final List<String> coveringAreas;
  TruckDetails({
    required this.titleText,
    required this.startStation,
    required this.departureTime,
    required this.truckNumber,
    required this.runby,
    required this.coveringAreas,
  });

  TruckDetails copyWith({
    String? titleText,
    String? startStation,
    String? departureTime,
    String? truckNumber,
    String? runby,
    List<String>? coveringAreas,
  }) {
    return TruckDetails(
      titleText: titleText ?? this.titleText,
      startStation: startStation ?? this.startStation,
      departureTime: departureTime ?? this.departureTime,
      truckNumber: truckNumber ?? this.truckNumber,
      runby: runby ?? this.runby,
      coveringAreas: coveringAreas ?? this.coveringAreas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titleText': titleText,
      'startStation': startStation,
      'departureTime': departureTime,
      'truckNumber': truckNumber,
      'runby': runby,
      'coveringAreas': coveringAreas,
    };
  }

  factory TruckDetails.fromMap(Map<String, dynamic> map) {
    return TruckDetails(
      titleText: map['titleText'] ?? '',
      startStation: map['startStation'] ?? '',
      departureTime: map['departureTime'] ?? '',
      truckNumber: map['truckNumber'] ?? '',
      runby: map['runby'] ?? '',
      coveringAreas: List<String>.from(map['coveringAreas']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TruckDetails.fromJson(String source) =>
      TruckDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TruckDetails(titleText: $titleText, startStation: $startStation, departureTime: $departureTime, truckNumber: $truckNumber, runby: $runby, coveringAreas: $coveringAreas)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruckDetails &&
        other.titleText == titleText &&
        other.startStation == startStation &&
        other.departureTime == departureTime &&
        other.truckNumber == truckNumber &&
        other.runby == runby &&
        listEquals(other.coveringAreas, coveringAreas);
  }

  @override
  int get hashCode {
    return titleText.hashCode ^
        startStation.hashCode ^
        departureTime.hashCode ^
        truckNumber.hashCode ^
        runby.hashCode ^
        coveringAreas.hashCode;
  }
}
