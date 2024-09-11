import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  static const String kLocationServicesDisabledMessage = 'Location services are disabled.';
  static const String kPermissionDeniedMessage = 'Permission denied.';
  static const String kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null;
    }

    try {
      return await _geolocatorPlatform.getCurrentPosition();
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<bool> _handlePermission() async { // Permission Controller for Location Service
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print(kLocationServicesDisabledMessage);
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        print(kPermissionDeniedMessage);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(kPermissionDeniedForeverMessage);
      return false;
    }

    print(kPermissionGrantedMessage);
    return true;
  }
}
