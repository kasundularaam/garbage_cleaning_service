import 'package:location/location.dart';

import '../../data/models/lat_long.dart';

class LocationServices {
  static Location location = Location();

  static Stream<LocationData> get locationStream => location.onLocationChanged;
  static Future<LatLong> currentLocation() async =>
      await location.getLocation().then((loc) => LatLong(
            lat: loc.latitude!,
            long: loc.longitude!,
          ));

  static Future<bool> isPermissionAllowed() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    return true;
  }
}
