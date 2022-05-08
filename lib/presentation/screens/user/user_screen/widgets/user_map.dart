import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

import '../../../../../logic/cubit/all_trucks_cubit/all_trucks_cubit.dart';

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
    return BlocListener<AllTrucksCubit, AllTrucksState>(
      listener: (context, state) {
        if (state is AllTrucksLoaded) {
          log(state.markers.length.toString());
          setState(() {
            markers = state.markers;
          });
        }
      },
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: latLng.LatLng(6.9271, 79.8612),
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) =>
                const Text("© OpenStreetMap contributors"),
          ),
          MarkerLayerOptions(
            markers: markers,
          ),
        ],
      ),
    );
  }
}
