import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlong;

import 'package:provider/provider.dart';

import 'package:flalog/models/pharmacy.dart';
import 'package:flalog/theme/app_theme.dart';

import '../helpers/constats.dart';
import '../helpers/marker_data.dart';
import '../providers/marker_proviser.dart';

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();

  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.selectedPharmacy,
  }) : super(key: key);

  final Pharmacy selectedPharmacy;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final PopupController _popupLayerController = PopupController();
  bool activateSearchWidget = false;
  double mapZoom = kStartZoom;
  double maxZoom = kMaxZoom;
  MapController? mapController;
  bool isInitCalled = false;
  // WidgetToDisplay widgetToDisplay;

  late AnimationController _animationController;
  late Animation<double> _heightFactorAnimation;
  final double collapsedHeightFactor = 0.7;
  final double expandedHeightFactor = 0.15;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    // widgetToDisplay = WidgetToDisplay.STOP_INFO;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_animationController);
  }

  void _animatedMapMove(latlong.LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController!.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController!.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController!.zoom, end: destZoom);
    final rotationTween = Tween<double>(begin: mapController!.rotation, end: 0);

    // rotate the map to be in the first rotation value
    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController!.moveAndRotate(
          latlong.LatLng(
              latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation),
          rotationTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  // List<Marker> getSelectedPointMarker(BuildContext context) {
  //   if (Provider.of<MarkersProvider>(context).selectedPoint != null) {
  //     return [Provider.of<MarkersProvider>(context).selectedPoint.marker];
  //   } else {
  //     return [];
  //   }
  // }

  List<Marker> getSelectedPharmacyMarker(BuildContext context) {
    return [
      Marker(
          builder: (context) => InkWell(
              onTap: () {},
              child: MarkerData.getBuilder(MarkerType.pharmacyMarker)),
          point: widget.selectedPharmacy.position)
    ];
  }

  void _onMarkerTapped(Marker marker) {
    _animatedMapMove(marker.point, mapZoom);
  }

  List<Marker> getMyPositionMarker(BuildContext context) {
    if (Provider.of<MarkersProvider>(context).actualPosition != null) {
      return [Provider.of<MarkersProvider>(context).actualPosition!.marker];
    } else {
      return [];
    }
  }

  List<Marker> getFavoritsMarkers(BuildContext context) {
    return Provider.of<MarkersProvider>(context).favoritsMarkers;
  }

  Widget getWidget(BuildContext context) {
    double zoom = mapZoom;
    return Stack(
      fit: StackFit.expand,
      children: [
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: _heightFactorAnimation.value,
          child: Stack(
            children: [
              !isInitCalled
                  ? Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Chargement..."),
                      ),
                    )
                  : FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center:
                            Provider.of<MarkersProvider>(context, listen: false)
                                .myPosition,
                        zoom: mapZoom,
                        maxZoom: maxZoom,
                        onPositionChanged: (pos, flag) {
                          if ((pos.zoom! >= kMinZoomStationDisplay &&
                                  zoom <= kMinZoomStationDisplay) ||
                              (pos.zoom! <= kMinZoomStationDisplay &&
                                  zoom >= kMinZoomStationDisplay)) {
                            setState(() {
                              mapZoom = pos.zoom!;
                            });
                          }
                          zoom = pos.zoom!;

                          //mapController.rotate(mapController.rotation);
                        },
                        onTap: (pos, latLng) {},
                      ),
                      //  layers: [
                      // TileLayerOptions(
                      //     urlTemplate:
                      //         "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      //     //subdomains: ['a', 'b', 'c'],
                      //     subdomains: ['a'],
                      //     tileProvider: const CachedTileProvider()),
                      // MarkerLayerOptions(
                      //     markers: getSelectedPharmacyMarker(context)),
                      //MarkerLayerOptions(
                      //  markers: getFavoritsMarkers(context)),
                      // MarkerLayerOptions(
                      //     markers: getMyPositionMarker(context)),
                      //   ],
                      children: [
                      
                        TileLayerWidget(
                          options: TileLayerOptions(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                        ),
                          MarkerLayerWidget(
                          options: MarkerLayerOptions(
                            markers: getMyPositionMarker(context),
                          ),
                        ),
             
                        PopupMarkerLayerWidget(
                          options: PopupMarkerLayerOptions(
                            popupController: _popupLayerController,
                            markers: getSelectedPharmacyMarker(context),
                            markerRotateAlignment:
                                PopupMarkerLayerOptions.rotationAlignmentFor(
                                    AnchorAlign.top),
                            popupBuilder: (context, marker) => FittedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppTheme.green,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "3",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Min",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${widget.selectedPharmacy.name}",
                                            style: TextStyle(
                                                color: AppTheme.green,
                                                fontSize: 20),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "${widget.selectedPharmacy.city}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              Positioned(
                bottom: 100.0,
                right: 10.0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white70, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        mapZoom = maxZoom;
                      });

                      await Provider.of<MarkersProvider>(context, listen: false)
                          .updateMyPosition();

                      _animatedMapMove(
                          Provider.of<MarkersProvider>(context, listen: false)
                              .myPosition!,
                          mapZoom);
                      // // update the selected marker
                      Provider.of<MarkersProvider>(context, listen: false)
                          .updateSelectedMarker(MarkerType.myPositionMarker);
                    },
                    icon: Icon(
                      FontAwesomeIcons.locationArrow,
                      color: AppTheme.green,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          //heightFactor: 1.05 - _heightFactorAnimation.value,
          heightFactor: 1 - _heightFactorAnimation.value,
          child: Container(
            // child: this.isAnimationCompleted
            //     ;
            //Container(color: Colors.red),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.09,
            child: Container())
      ],
    );
  }

  Future<void> initMarlers(BuildContext context) async {
    if (!isInitCalled) {
      if (Provider.of<MarkersProvider>(context, listen: false).initFinished ==
          true) {
        setState(() {
          isInitCalled = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initMarlers(context);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        return Scaffold(body: getWidget(context));
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heightFactorAnimation.removeListener(() {});
    super.dispose();
  }
}









  // final Completer<GoogleMapController> _controller = Completer();
  // late BitmapDescriptor sourceIcon;
  // late BitmapDescriptor destinationIcon;

  // late LatLng currentLocation;
  // late LatLng destinationLocation;
  // late LatLng pharmacyPosition;
  // late CameraPosition initialCameraPosition;
  // @override


  // void didChangeDependencies() {
  //   final pharmacy = ModalRoute.of(context)!.settings.arguments as Pharmacy;
  //   pharmacyPosition = LatLng(pharmacy.lat, pharmacy.long);
  //   initialCameraPosition = CameraPosition(
  //       zoom: 16, tilt: 80, bearing: 30, target: pharmacyPosition);
  //   setInitialLocation();
  //   super.didChangeDependencies();
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  // void setInitialLocation() {
  //   currentLocation =
  //       LatLng(pharmacyPosition.latitude, pharmacyPosition.longitude);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: GoogleMap(
  //       initialCameraPosition: initialCameraPosition,
  //     ),
  //   );
  // }

