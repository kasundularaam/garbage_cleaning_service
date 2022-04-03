import 'package:bloc/bloc.dart';
import 'package:garbage_cleaning_service/core/uses_permission/location_services.dart';
import 'package:meta/meta.dart';

import '../../../data/models/lat_long.dart';
import '../../../data/socket/user_socket.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());
  UserSocket userSocket = UserSocket();

  Future<void> getLocation() async {
    try {
      emit(GetLocationLoading());
      LatLong latLong = await LocationServices.currentLocation();
      emit(GetLocationSucceed(latLong: latLong));
    } catch (e) {
      emit(GetLocationFailed(errorMsg: e.toString()));
    }
  }

  void dispose() => userSocket.dispose();
}
