import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/lat_long.dart';
import '../../../data/socket/user_socket.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());
  UserSocket userSocket = UserSocket();

  void getLocation() {
    try {
      userSocket.getLocation().listen((latLong) {
        // emit(GetLocationGetting(latLong: latLong));
      });
    } catch (e) {
      emit(GetLocationFailed(errorMsg: e.toString()));
    }
  }

  void dispose() => userSocket.dispose();
}
