import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:garbage_cleaning_service/core/themes/app_colors.dart';
import 'package:garbage_cleaning_service/logic/cubit/get_location_cubit/get_location_cubit.dart';
import "package:latlong2/latlong.dart" as latLng;

import '../../../../../logic/cubit/all_trains_cubit/all_trains_cubit.dart';

class UserMap extends StatefulWidget {
  const UserMap({Key? key}) : super(key: key);

  @override
  State<UserMap> createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  MapController mapController = MapController();

  List<Marker> markers = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetLocationCubit>(context).getLocation();
    return BlocListener<AllTrainsCubit, AllTrainsState>(
      listener: (context, state) {
        if (state is AllTrainsLoaded) {
          log(state.markers.length.toString());
          setState(() {
            markers = state.markers;
          });
        }
      },
      child: BlocConsumer<GetLocationCubit, GetLocationState>(
        listener: (context, state) {
          if (state is GetLocationFailed) {
            SnackBar snackBar = SnackBar(
              content: Text(
                state.errorMsg,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is GetLocationSucceed) {
            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: latLng.LatLng(state.latLong.lat, state.latLong.long),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) =>
                      const Text("© OpenStreetMap contributors"),
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            );
          } else if (state is GetLocationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else {
            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: latLng.LatLng(6.9271, 79.8612),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) =>
                      const Text("© OpenStreetMap contributors"),
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
