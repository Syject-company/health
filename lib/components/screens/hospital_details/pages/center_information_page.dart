import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/hospital_details/widgets/hospital_card.dart';
import 'package:health_plus/components/screens/hospital_details/widgets/qr_code_card.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/model/provider.dart';

class CenterInformationPage extends StatefulWidget {
  const CenterInformationPage({Key? key}) : super(key: key);

  @override
  State<CenterInformationPage> createState() => _CenterInformationPageState();
}

class _CenterInformationPageState extends State<CenterInformationPage> {
  late final BitmapDescriptor pinLocationIcon;
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
    final provider = context.providerBloc.state.provider;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HospitalCard(),
          const SizedBox(height: 24.0),
          const QrCodeCard(),
          const SizedBox(height: 20.0),
          _buildAboutCenter(provider),
          const SizedBox(height: 20.0),
          _buildGEOLocation(),
        ],
      ),
    );
  }

  Widget _buildAboutCenter(Provider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'text.about_center'.tr(),
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          provider.description,
          textAlign: TextAlign.start,
          style: const TextStyle(
            height: 1.57,
            fontSize: 14.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildGEOLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'text.location'.tr(),
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 164.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13.0),
            child: GoogleMap(
              compassEnabled: false,
              mapToolbarEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              gestureRecognizers: {
                Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
                Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
                Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer()),
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
            ),
          ),
        ),
      ],
    );
  }
}
