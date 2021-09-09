import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapGoogle extends StatefulWidget {
  @override
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {



  Location _location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;



  void _checkLocationPermission() async {

    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await _location.getLocation();

    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
  }

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set();

  List<Marker> addMarkers = [



    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "مسجد الستار",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(29.974537, 31.051417)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "Misr Pharmacies",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(29.970567, 31.037792)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "Kalawy Market",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: LatLng(29.975676, 31.051405)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "Rania Pharmacy",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(29.975156, 31.050934)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "Dream cafe",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.975347, 31.051253)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "Freddy's cafe",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.975414, 31.051692)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
          title: "TK BURGERS N FRIES",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.975568, 31.051538)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "Friend's laundry"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.975353, 31.051165)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "Dream International School"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.975706, 31.052878)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "مسجد التلاوي"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.967725, 31.052900)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "السعودي ماركت"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.958395, 31.059681)),


    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "Cinema Dream"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.959896, 31.059881)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "Pegasus dreamland club"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.961645, 31.048736)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(title: "Al Bahga Market"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.970364, 31.038055)),
    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(anchor: Offset.infinite, title: "مسجد المروة"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.971094, 31.037836)),

    Marker(
        markerId: MarkerId(""),
        infoWindow:
            InfoWindow(anchor: Offset.infinite, title: "مطعم زيت وليمون"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.970207, 31.037744)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
            anchor: Offset.infinite,
            title: "Dream Hospital Emergency"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.972750, 31.038369)),

    Marker(
        markerId: MarkerId(""),
        infoWindow: InfoWindow(
            anchor: Offset.infinite, title: "الطباخ(فول و طعمية)"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(29.9707454,31.0378342)),
  ];

  @override
  void initState() {
    print("*********************************************");
    super.initState();
    markers.addAll(addMarkers); // add markers to the list
    _checkLocationPermission();
    print("*********************************************");
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.965561, 31.038659),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(29.970253, 31.037149),
      tilt: 59.440717697143555,
      zoom: 16.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To Dream Land'),
        icon: Icon(Icons.location_city),
      ),*/
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
