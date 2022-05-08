import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

import '../../../data/socket/user_socket.dart';
import '../../../presentation/screens/user/user_screen/widgets/marker_view.dart';

part 'all_trucks_state.dart';

class AllTrucksCubit extends Cubit<AllTrucksState> {
  AllTrucksCubit() : super(AllTrucksInitial());

  UserSocket userSocket = UserSocket();
  List<Marker> markers = [];
  List<String> trainIds = [];

  Future<void> loadTrains() async {
    try {
      emit(AllTrucksLoading());

      userSocket.getLocation().listen((trainLocation) {
        if (!trainIds.contains(trainLocation.trainId)) {
          Marker marker = Marker(
            width: 200,
            height: 200,
            point:
                latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
            builder: (context) => MarkerView(trainLocation: trainLocation),
          );
          trainIds.add(trainLocation.trainId);
          markers.add(marker);
        }
        if (trainIds.contains(trainLocation.trainId)) {
          Marker marker = Marker(
            width: 200,
            height: 200,
            point:
                latLng.LatLng(trainLocation.latitude, trainLocation.longitude),
            builder: (context) => MarkerView(trainLocation: trainLocation),
          );
          final index = trainIds.indexOf(trainLocation.trainId);
          markers[index] = marker;
        }
        emit(AllTrucksLoaded(markers: markers));
      });
    } catch (e) {
      emit(AllTrucksFailed(errorMsg: e.toString()));
    }
  }

  void dispose() => userSocket.dispose();
}
