import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitud;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitud = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
