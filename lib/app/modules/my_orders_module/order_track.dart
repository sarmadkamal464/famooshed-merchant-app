import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:famooshed_vendor/app/modules/widgets/base_widget.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_google_map_polyline_point/flutter_polyline_point.dart';
import 'package:flutter_google_map_polyline_point/point_lat_lng.dart';
import 'package:flutter_google_map_polyline_point/utils/polyline_result.dart';
import 'package:flutter_google_map_polyline_point/utils/request_enums.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/order_list_response.dart';
import '../../utils/dprint.dart';

class OrderMapScreen extends StatefulWidget {
  final Order currentOrder;
  OrderMapScreen({required this.currentOrder});

  @override
  _OrderMapScreenState createState() => _OrderMapScreenState();
}

class _OrderMapScreenState extends State<OrderMapScreen> {
  var windowWidth;
  var windowHeight;
  String _mapStyle = "";

  @override
  void initState() {
    _initIcons();
    super.initState();
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
    addPolyLine();
  }

  Map<PolylineId, Polyline> mapPolylines = {};
  Future<void> addPolyLine() async {
    double restaurantLat = double.parse(widget.currentOrder.latRest.toString());
    double restaurantLang =
        double.parse(widget.currentOrder.lngRest.toString());

    double customerLat = double.parse(widget.currentOrder.lat.toString());
    double customerLang = double.parse(widget.currentOrder.lng.toString());

    // double restaurantLat = 21.1702;
    // double restaurantLang = 72.8311;
    //
    // double customerLat = 23.0225;
    // double customerLang = 72.5714;

    debugPrint(
        "RESTAURANT LAT LONG\n Lat>>>>>>>$restaurantLat LNG>>>>>>>>>$restaurantLang");
    debugPrint(
        "CUSTOMER LAT LONG\n Lat>>>>>>>$customerLat LNG>>>>>>>>>$customerLang");
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    // polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    var polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAyrWhY3ALKo6NORh9f_gcwGGdWPT3Phdk",

      PointLatLng(restaurantLat, restaurantLang),
      // PointLatLng(22.9642, 72.5903),
      PointLatLng(customerLat, customerLang),
      // PointLatLng(23.0686, 72.6536),
      travelMode: TravelMode.driving,
    );
    if (mapPolylines.containsKey(polylineId)) {}
    List<LatLng> polylineCoordinates = [];

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      // patterns: [
      //   PatternItem.dash(25),
      //   PatternItem.gap(20),
      // ],
      color: Colors.black,
      geodesic: true,
      endCap: Cap.squareCap,
      jointType: JointType.mitered,
      width: 3,
      points: polylineCoordinates,
    );

    mapPolylines[polylineId] = polyline;

    _addMarker(LatLng(restaurantLat, restaurantLang),
        LatLng(customerLat, customerLang));
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
    if (_controller != null) _controller!.dispose();
    super.dispose();
  }

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.0225, 72.5714),
    zoom: 12,
  ); // paris coordinates
  // Set<Marker> markers = {};
  GoogleMapController? _controller;
  double _currentZoom = 14;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Stack(children: <Widget>[
          _map(),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height: getProportionateScreenHeight(45),
                width: getProportionateScreenWidth(45),
                decoration: BoxDecoration(
                  color: AppColors.appTheme,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(
                    top: getProportionateScreenHeight(30),
                    left: getProportionateScreenWidth(16)),
                child: Container(
                  margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(8),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
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
        ])),
      ),
    );
  }

  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;

  List<Marker> markers = [];
  _addMarker(LatLng restaurantLatLng, LatLng customerLatLng) {
    MarkerId _sourceMarkerId = MarkerId("sourceMarkerId");
    final marker1 = Marker(
        markerId: _sourceMarkerId,
        icon: _iconDest,
        // rotation: currentLatLng.,
        position: restaurantLatLng,
        onTap: () {});

    MarkerId _destMarkerId = MarkerId("destMarkerId");
    final marker2 = Marker(
        markerId: _destMarkerId,
        icon: _iconHome,
        position: customerLatLng,
        onTap: () {});

    // MarkerId _driverMarkerId = MarkerId("driverMarkerId");
    // final marker3 = Marker(
    //     markerId: _driverMarkerId,
    //     icon: _iconDriver,
    //     anchor: const Offset(0.5, 0.5),
    //     flat: true,
    //     rotation:
    //     currentPositionData != null ? currentPositionData!.heading : 0,
    //     position: LatLng(sourceLatLng.latitude, sourceLatLng.longitude),
    //     // position: LatLng(23.0686, 72.6536),
    //     onTap: () {});

    final oldSourceMarkerId = markers
        .indexWhere((marker) => marker.markerId == MarkerId('sourceMarkerId'));
    if (oldSourceMarkerId >= 0) {
      // If it exists
      markers[oldSourceMarkerId] = marker1;
    } else {
      markers.add(marker1);
    }

    final oldDestinationMarkerId = markers
        .indexWhere((marker) => marker.markerId == MarkerId('destMarkerId'));
    if (oldDestinationMarkerId >= 0) {
      // If it exists
      markers[oldDestinationMarkerId] = marker2;
    } else {
      markers.add(marker2);
    }
    //
    // final oldDriverMarkerId = markers
    //     .indexWhere((marker) => marker.markerId == MarkerId('driverMarkerId'));
    // if (oldDriverMarkerId >= 0) {
    //   // If it exists
    //   markers[oldDriverMarkerId] = marker3;
    // } else {
    //   markers.add(marker3);
    // }

    if (restaurantLatLng.latitude <= customerLatLng.latitude) {
      LatLngBounds bound =
          LatLngBounds(southwest: restaurantLatLng, northeast: customerLatLng);
      CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 90);
      _controller!.animateCamera(u2).then((void v) {
        check(u2, _controller!);
      });
    } else {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: customerLatLng,
            zoom: _currentZoom,
            // bearing: currentPositionData.heading
          ),
        ),
      );
    }

    setState(() {});
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    _controller!.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
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
        polylines: Set<Polyline>.of(mapPolylines.values),
        onCameraMove: (CameraPosition cameraPosition) {
          _currentZoom = cameraPosition.zoom;
        },
        onTap: (LatLng pos) {},
        onLongPress: (LatLng pos) {},
        markers: markers.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
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
