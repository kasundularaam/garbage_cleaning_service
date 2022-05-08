import 'dart:convert';

import '../models/station.dart';
import '../models/truck_details.dart';

class HttpListConverter {
  static List<Station> parseStations(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Station>(
          (json) => Station.fromMap(json),
        )
        .toList();
  }

  static List<TruckDetails> parseTrains(String responseBody) {
    List<TruckDetails> list = [];
    List<Map<String, dynamic>> parsed =
        json.decode(responseBody).cast<Map<String, dynamic>>();

    for (var item in parsed) {
      if (item.length >= 10) {
        list.add(TruckDetails.fromMap(item));
      }
    }
    return list;
  }
}
