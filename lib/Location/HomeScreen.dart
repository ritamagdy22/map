import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map/Location/MyLocation_Provider.dart';

class HommeScreen extends StatefulWidget {
  static const String routename = "HomeScreen";
  @override
  State<HommeScreen> createState() => _HommeScreenState();
}
class _HommeScreenState extends State<HommeScreen> {
  MyLocationProvider locationProvider = MyLocationProvider();
  CameraPosition routeMap=  CameraPosition(
    //target : al mkan al ana 3aiza aro7o
      target: LatLng(31.247047, 29.974500),
      zoom:  19
  );

  /*
  we have 2 routes : one for route center , one for usermarkerid
  route : ana m7deda an al location yzbout w yfta7 3ala route

   */
  static const String routeID = "route";
  static const String UserMArkerID = "UserMArkerID";

  GoogleMapController? mapcontroller;
  StreamSubscription<LocationData>?streamSubscription;
  Set<Marker> markers ={
    Marker(markerId: (MarkerId(routeID)),
//31.247047,29.974500
    position: LatLng(31.247047, 29.974500)
    )

  };

  @override
  // init state: awel  ma al app yfta7 ytl3lo al message de

void initState() {
    // TODO: implement initState
    super.initState();
    trackUserLocation();
  }


  @override
  Widget build(BuildContext context) {
    locationProvider.LocationManager.changeSettings(

      accuracy: LocationAccuracy.high,
      interval: 2000,
      distanceFilter: 10

    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,

        //  initialCameraPosition:routeMap :eh al mkan al mafrod ygy 3alih al camera ? aw al location?
        initialCameraPosition:routeMap ,

        // control al map
        onMapCreated: (controller){
          // ha8ir eimt al controller amta ? mn al callback function mn al controller
          mapcontroller = controller;

        } ,
        myLocationEnabled:  true,
        markers: markers,
      ),
    );
  }

  trackUserLocation() async {
    var locationdata = await locationProvider.getUserLocation();
    print(locationdata?.latitude ?? "0");
    print(locationdata?.longitude ?? "0");

    // lagtidtude , longtitude : artfa3 3an mostawa sat7 al ba7 ba kam ?

    // zi uber w carem ygyb al user w howa byt7rak
    // locationprovide : let user select location on the app
streamSubscription=locationProvider.TrackuserLocation().listen((newLocation)
{
  print(newLocation.longitude);
  print(newLocation.latitude);

  // (marker for user)
  Marker userMarker = Marker(markerId: MarkerId(UserMArkerID),
//when the location of the user changed marker must be changed to
  position: LatLng(newLocation.latitude??0, newLocation.longitude??0)
  );
markers.add(userMarker);
/*
msh 3aiza a3ml zoom manually 3iza lama al user yt7rab al camera tet7rak ma3ah
 */
mapcontroller?.animateCamera(

CameraUpdate.newLatLngZoom(LatLng(newLocation.latitude??0, newLocation.longitude??0),12


)

);


  setState(() {

  });
});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSubscription?.cancel();
  }

}
