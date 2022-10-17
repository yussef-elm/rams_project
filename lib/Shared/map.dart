
import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rams_project/Services/locationSevice.dart';

import '../constants.dart';

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {

  var currentPosition ;
  double? lat ;
  double? long;

  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();

  CameraPosition? _kGooglePlex ;
  Set<Marker> myMarkers= {};

  @override
  void initState()  {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return _kGooglePlex == null ? Center (
                                              child: Container(
                                                  height: 400,
                                                  alignment: Alignment.topCenter,
                                                  child: CircularProgressIndicator(
                                                    color: kPrimaryColor,
                                                  )
                                              )
    ) :
    new Scaffold(
      body: Column(
        children: [
          /*Row(children: [
            Expanded(child :TextField(
              controller: _searchController,
              textCapitalization: TextCapitalization.words,
              decoration: (InputDecoration(hintText: "Search")),
              onChanged: (value) {
                print(value);
              },
            )),
            IconButton(
              onPressed: () {
                LocationService().getPalceId(_searchController.text);
              } ,
              icon: Icon(Icons.search),
            ),
          ],
          ),*/
          Center(
            child: Container(
              height : 400,
              child: GoogleMap(
              mapType: MapType.normal,
              markers: myMarkers,
              initialCameraPosition: _kGooglePlex! ,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),),
          ),
        ],
      ),
    );
  }

 /* Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  /*Future<void> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition= await Geolocator.getCurrentPosition(forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.best).then((value) => value);
    print(currentPosition.longitude);
    print(currentPosition.latitude);

    setState((){
      print(currentPosition.longitude);
      print(currentPosition.latitude);
    });
  }*/
   getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position =
    await Geolocator.getCurrentPosition(forceAndroidLocationManager: true, desiredAccuracy: LocationAccuracy.best);
    print(position.latitude.toString() + ":" + position.longitude.toString());

    setState(() {
      lat  = position.latitude;
      long = position.longitude;
      _kGooglePlex= CameraPosition(target: LatLng(lat!,long!),zoom: 14);
      myMarkers.add(Marker(markerId: const MarkerId('current Location'),
                           position: LatLng(lat!, long!),
                           infoWindow: InfoWindow(title: "My position")));
    });

  // _kGooglePlex = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long), zoom: 14)) as CameraPosition;
  }
}