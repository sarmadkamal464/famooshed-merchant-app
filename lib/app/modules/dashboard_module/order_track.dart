import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_google_map_polyline_point/flutter_polyline_point.dart';
import 'package:flutter_google_map_polyline_point/point_lat_lng.dart';
import 'package:flutter_google_map_polyline_point/utils/polyline_result.dart';
import 'package:flutter_google_map_polyline_point/utils/request_enums.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../data/models/get_my_driver_response.dart';
import '../../utils/dprint.dart';

class MapTrackingScreen extends StatefulWidget {
  MapTrackingScreen();

  @override
  _MapTrackingScreenState createState() => _MapTrackingScreenState();
}

class _MapTrackingScreenState extends State<MapTrackingScreen> {
  var windowWidth;
  var windowHeight;
  String _mapStyle = "";

  @override
  void initState() {
    _initIcons();
    _getCurrentLocation();
    startTimer();
    // rootBundle.loadString('assets/map_style.txt').then((string) {
    //   _mapStyle = string;
    //   _controller!.setMapStyle(_mapStyle);
    // });

    // _add();
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   _initCameraPosition();
    // });
    super.initState();
  }

  Timer? _timer;

  void startTimer() {
    dprint("start timer");
    _timer = new Timer.periodic(
      Duration(seconds: 10),
      (Timer timer) {
        _loadDriverLocation();
      },
    );
  }

  Future<void> _loadDriverLocation() async {
    List<Driver> data = await getDriverLocation();

    if (data.isNotEmpty) {
      data.forEach((element) {
        if (element.lat != null &&
            element.lat!.isNotEmpty &&
            element.lng != null &&
            element.lng!.isNotEmpty) {
          MarkerId _lastMarkerId = MarkerId(element.id.toString());

          final marker = Marker(
              markerId: _lastMarkerId,
              icon: _iconDriver,
              position: LatLng(
                  double.parse(element.lat!), double.parse(element.lng!)),
              onTap: () {});
          dprint("add driver marker");
          markers.add(marker);
        }
      });
    }

    setState(() {});
  }

  Future<List<Driver>> getDriverLocation() async {
    List<Driver> data = [];
    // LoadingDialog.showLoadingDialog();
    final ApiHelper _apiHelper = ApiHelper.to;

    try {
      Uri driverLocUri = Uri.parse(AppUrl.driversList);

      Response driverLocRes = await _apiHelper.postApi(driverLocUri.toString(),
          {"search": "", "sortOnline": "", "sortOffline": ""});

      if (driverLocRes.statusCode == 200) {
        var response = GetMyDriverResponse.fromJson(driverLocRes.body);
        if (response.error == "0") {
          if (response.driversAll != null && response.driversAll!.isNotEmpty) {
            data = response.driversAll!;
          }
        }
      }
    } catch (e) {
      print(e.toString());
      // LoadingDialog.closeLoadingDialog();
    }

    // LoadingDialog.closeLoadingDialog();
    // setState(() {});
    return data;
  }

  var _iconHome;
  var _iconDest;
  var _iconDriver;

  _initIcons() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/marker1.png', 80);
    _iconHome = BitmapDescriptor.fromBytes(markerIcon);
    final Uint8List markerIcon2 =
        await getBytesFromAsset('assets/marker2.png', 80);
    _iconDest = BitmapDescriptor.fromBytes(markerIcon2);
    final Uint8List markerIcon3 =
        await getBytesFromAsset('assets/marker3.png', 100);
    _iconDriver = BitmapDescriptor.fromBytes(markerIcon3);
    setState(() {});
    await _loadDriverLocation();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    if (_controller != null) _controller!.dispose();
    super.dispose();
  }

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(48.836010, 2.331359),
    zoom: 12,
  ); // paris coordinates
  Set<Marker> markers = {};
  GoogleMapController? _controller;
  double _currentZoom = 12;

  @override
  Widget build(BuildContext context) {
    // _controller!.setMapStyle(_mapStyle);

    return Container(
        // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(children: <Widget>[
      _map(),
      Align(
        alignment: Alignment.centerRight,
        child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                buttonPlus(_onMapPlus),
                buttonMinus(_onMapMinus),
                buttonMyLocation(_getCurrentLocation),
              ],
            )),
      ),
      // skinHeaderBackButton(context, Colors.white),
    ]));
  }

  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;

  Future<void> _add() async {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    var polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAyj8XQ2neCkrJ-7yQ2UtXXCVz4-MaFMik",
      PointLatLng(23.0296, 72.5301),
      PointLatLng(23.0387, 72.6308),
      travelMode: TravelMode.driving,
    );
    List<LatLng> polylineCoordinates = [];

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 4,
      points: polylineCoordinates,
    );
    // _loadDriverLocation();
    setState(() {
      _mapPolylines[polylineId] = polyline;
    });
    _addMarker();
    // _initCameraPosition();
  }

  _addMarker() {
    print("add marker addr1 and addr2");
    MarkerId _lastMarkerId = MarkerId("addr1");
    final marker = Marker(
        markerId: _lastMarkerId,
        icon: _iconDest,
        position: LatLng(23.0387, 72.6308),
        onTap: () {});
    markers.add(marker);
    _lastMarkerId = MarkerId("addr2");
    final marker2 = Marker(
        markerId: _lastMarkerId,
        icon: _iconHome,
        position: LatLng(23.0296, 72.5301),
        onTap: () {});
    markers.add(marker2);
    setState(() {});
  }

  _initCameraPosition() async {
    // calculate zoom
    LatLng latLng_1 = LatLng(23.0296, 72.5301);
    LatLng latLng_2 = LatLng(23.0387, 72.6308);
    dprint("latLng      _initCameraPosition();_1 = $latLng_1");
    dprint("latLng_2 = $latLng_2");

    var lat1 = latLng_1.latitude; // широта
    var lat2 = latLng_2.latitude;
    if (latLng_1.latitude > latLng_2.latitude) {
      lat1 = latLng_2.latitude;
      lat2 = latLng_1.latitude;
    }
    var lng1 = latLng_1.longitude;
    var lng2 = latLng_2.longitude;
    if (latLng_1.longitude > latLng_2.longitude) {
      lng1 = latLng_2.longitude;
      lng2 = latLng_1.longitude;
    }
    dprint("lat1 = $lat1, lat2 = $lat2");
    dprint("lng1 = $lng1, lng2 = $lng2");
    LatLngBounds bound = LatLngBounds(
        southwest: LatLng(lat1, lng1),
        northeast: LatLng(lat2, lng2)); // юго-запад - северо-восток
    dprint(bound.toString());

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    if (_controller != null) {
      print("animateCamera");
      _controller!.animateCamera(u2).then((void v) {});
    }

    setState(() {});
  }

  _getCurrentLocation() async {
    Position position = await determinePosition();

    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: _currentZoom,
        ),
      ),
    );
    setState(() {});
  }

  Future<Position> determinePosition() async {
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

    return await Geolocator.getCurrentPosition();
  }

  _map() {
    dprint("orders.map : GoogleMap");
    return GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled:
            false, // Whether to show zoom controls (only applicable for Android).
        myLocationEnabled:
            true, // For showing your current location on the map with a blue dot.
        myLocationButtonEnabled:
            false, // This button is used to bring the user location to the center of the camera view.
        initialCameraPosition: _kGooglePlex,
        // polylines: Set<Polyline>.of(_mapPolylines.values),
        onCameraMove: (CameraPosition cameraPosition) {
          _currentZoom = cameraPosition.zoom;
        },
        onTap: (LatLng pos) {},
        onLongPress: (LatLng pos) {},
        // markers: markers,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          // _controller!.setMapStyle(_mapStyle);
          // if (idRestaurantOnMap != null)
          //   _navigateToMap();
        });
  }

  _onMapPlus() {
    _controller!.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }

  _onMapMinus() {
    _controller!.animateCamera(
      CameraUpdate.zoomOut(),
    );
  }

  buttonMyLocation(Function _getCurrentLocation) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(
              child: Icon(
            Icons.my_location,
            size: 30,
            color: Colors.black.withOpacity(0.5),
          )),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  _getCurrentLocation();
                }, // needed
              )),
        )
      ],
    );
  }

  buttonPlus(Function() callback) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(
              child: Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          )),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: callback, // needed
              )),
        )
      ],
    );
  }

  buttonMinus(Function() _onMapMinus) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(
              child: Icon(
            Icons.remove,
            size: 30,
            color: Colors.black,
          )),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: _onMapMinus, // needed
              )),
        )
      ],
    );
  }

// _getDistanceText(Restaurants item){
//   var _dist = "";
//   if (item.distance != -1) {
//     if (appSettings.distanceUnit == "km") {
//       if (item.distance <= 1000)
//         _dist = "${item.distance.toStringAsFixed(0)} m";
//       else
//         _dist = "${(item.distance / 1000).toStringAsFixed(0)} km";
//     }else{                // miles
//       if (item.distance < 1609.34) {
//         _dist = "${(item.distance/1609.34).toStringAsFixed(3)} miles";
//       }else
//         _dist = "${(item.distance / 1609.34).toStringAsFixed(0)} miles";
//     }
//   }
//   return _dist;
// }

// MarkerId _lastMarkerId;

// var _bearing = 0.0;

// _navigateToMap(){
//   for (var item in nearYourRestaurants)
//       if (item.id == idRestaurantOnMap) {
//         _controller.showMarkerInfoWindow(_lastMarkerId);
//         _controller.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 bearing: _bearing,
//                 target: LatLng(item.lat, item.lng),
//                 zoom: _currentZoom,
//               ),
//             )
//
//         );
//       }
// }
}

class IBoxCircle extends StatelessWidget {
  @required
  final Function()? press;
  final Widget child;
  final Color color;
  IBoxCircle({this.color = Colors.white, this.press, required this.child});

  @override
  Widget build(BuildContext context) {
    // Widget _child = Container();
    // if (child != null)
    //   _child = child;
    return Container(
      margin: EdgeInsets.all(5),
      child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(40),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Container(
//              margin: EdgeInsets.only(left: 10),
              child: child)),
    );
  }
}
