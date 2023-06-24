import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:map/Location/MyLocation_Provider.dart';

class HommeScreen extends StatefulWidget {
  static const String routename = "HomeScreen";

  @override
  State<HommeScreen> createState() => _HommeScreenState();
}

class _HommeScreenState extends State<HommeScreen> {
  MyLocationProvider locationProvider = MyLocationProvider();

  @override
  // init state: awel  ma al app yfta7 ytl3lo al message de
  /*
void initState() {
    // TODO: implement initState
    super.initState();

    trackUserLocation();
  }
 */

  @override
  Widget build(BuildContext context) {
    locationProvider.LocationManager.changeSettings(

      accuracy: LocationAccuracy.high,
      interval: 2000,
      distanceFilter: 10

    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            trackUserLocation();
          },
          child: Text('user location'),
        ),
      ),
    );
  }

  trackUserLocation() async {
    var locationdata = await locationProvider.getUserLocation();
    print(locationdata?.latitude ?? "0");
    print(locationdata?.longitude ?? "0");

    // lagtidtude , longtitude : artfa3 3an mostawa sat7 al ba7 ba kam ?

    // zi uber w carem ygyb al user w howa byt7rak
locationProvider.TrackuserLocation().listen((newLocation)
{
  print(newLocation.longitude);
  print(newLocation.latitude);
  setState(() {

  });
});
  }
}
