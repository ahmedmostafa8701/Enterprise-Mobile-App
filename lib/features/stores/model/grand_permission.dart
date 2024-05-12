import 'package:geolocator/geolocator.dart';

class GrantPermissions{
  static void grantLocationPermission() async{
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied
        print('Permission denied');
      }
    }
  }
}