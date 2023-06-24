import 'package:location/location.dart';

class MyLocationProvider {
  Location LocationManager = Location();

// ask user if GPS is open or not
  Future<bool> IsServiceEnable() async {
    var servideEnabled = await LocationManager.serviceEnabled();
    return servideEnabled;
  }

  //ask user to open GPS
  Future<bool> requestservice() async {
    var serviceenabled = await LocationManager.requestService();
    return serviceenabled;
  }

  //permission to acces location
  Future<bool> PermissionGranted() async {
    var permissionStatus = await LocationManager.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

//ask user to allow permission ti access location
  Future<bool> RequestPermission() async {
    var permissionStatus = await LocationManager.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }


  Future<LocationData?> getUserLocation() async {
    var serviceenable = await requestservice();
    var permissiongranted = await RequestPermission();
    if (!serviceenable || !permissiongranted) {
      return null;
    } else
      return LocationManager.getLocation();
  }


  Stream<LocationData>TrackuserLocation(){
    return LocationManager.onLocationChanged;
  }
}
