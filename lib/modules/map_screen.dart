import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/shared/Styles/colors.dart';
import 'package:maps/shared/location_helper.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../shared/components/drawer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getMyCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      iconColor: MyColors.blue,
      automaticallyImplyBackButton: false,
      actions: const [],
      borderRadius: BorderRadius.circular(12.0),
      margins: const EdgeInsetsDirectional.fromSTEB(15, 55, 15, 55),
      hint: 'Find a place...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56,),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const []
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : Center(
            child: CircularProgressIndicator(
              color: MyColors.blue,
            ),
          ),
          buildFloatingSearchBar(),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 32),
        child: FloatingActionButton(
          backgroundColor: MyColors.blue,
          onPressed: _goToMyCurrentLocation,
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
