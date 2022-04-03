part of 'get_location_cubit.dart';

@immutable
abstract class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class GetLocationLoading extends GetLocationState {}

class GetLocationSucceed extends GetLocationState {
  final LatLong latLong;
  GetLocationSucceed({
    required this.latLong,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetLocationSucceed && other.latLong == latLong;
  }

  @override
  int get hashCode => latLong.hashCode;

  @override
  String toString() => 'GetLocationSucceed(latLong: $latLong)';
}

class GetLocationFailed extends GetLocationState {
  final String errorMsg;
  GetLocationFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetLocationFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'GetLocationFailed(errorMsg: $errorMsg)';
}
