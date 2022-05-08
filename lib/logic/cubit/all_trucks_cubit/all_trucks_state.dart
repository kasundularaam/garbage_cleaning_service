part of 'all_trucks_cubit.dart';

@immutable
abstract class AllTrucksState {}

class AllTrucksInitial extends AllTrucksState {}

class AllTrucksLoading extends AllTrucksState {}

class AllTrucksLoaded extends AllTrucksState {
  final List<Marker> markers;
  AllTrucksLoaded({
    required this.markers,
  });
}

class AllTrucksFailed extends AllTrucksState {
  final String errorMsg;
  AllTrucksFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllTrucksFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AllTrucksFailed(errorMsg: $errorMsg)';
}
