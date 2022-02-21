import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/medical_network/widgets/filters_view.dart';

class MedicalNetworkMapPage extends StatefulWidget {
  const MedicalNetworkMapPage({Key? key}) : super(key: key);

  @override
  State<MedicalNetworkMapPage> createState() => _MedicalNetworkMapPageState();
}

class _MedicalNetworkMapPageState extends State<MedicalNetworkMapPage> {
  late final BitmapDescriptor pinLocationIcon;
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _googleMapController = Completer();

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _initializeCustomMapPin();
  }

  Future<void> _determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
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

    final position = await Geolocator.getCurrentPosition();

    (await _googleMapController.future).animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
  }

  void _initializeCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: window.devicePixelRatio),
      AppResources.mapPin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          compassEnabled: false,
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onTap: (position) {
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId(position.toString()),
                  position: LatLng(position.latitude, position.longitude),
                  icon: pinLocationIcon,
                ),
              );
            });
          },
          onMapCreated: (controller) async {
            final mapStyle =
                await rootBundle.loadString('assets/map_style.json');
            controller.setMapStyle(mapStyle);
            _googleMapController.complete(controller);
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(0.0, 0.0),
            zoom: 15.0,
          ),
          markers: _markers,
        ),
        _buildFiltersView(),
      ],
    );
  }

  Widget _buildFiltersView() {
    return const Align(
      alignment: AlignmentDirectional.topStart,
      child: FiltersView(
        insetPadding: EdgeInsets.all(16.0),
      ),
    );
  }
}
