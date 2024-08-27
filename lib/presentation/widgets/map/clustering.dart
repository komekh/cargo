import 'package:cargo/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../application/order_detail_bloc/order_detail_bloc.dart';

class ClusteringPage extends StatefulWidget {
  final VoidCallback onFullScreenToggle;
  final bool isFullScreen;

  const ClusteringPage({
    super.key,
    required this.onFullScreenToggle,
    required this.isFullScreen,
  });

  @override
  State<ClusteringPage> createState() => _ClusteringPageState();
}

class _ClusteringPageState extends State<ClusteringPage> {
  late List<Marker> markers;
  late List<Polyline> polylines;

  @override
  void initState() {
    super.initState();
    markers = [];
    polylines = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onFullScreenToggle, // Use the passed callback
        child: Icon(widget.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is RoutesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoutesLoaded) {
            markers = state.routes.map((route) {
              return Marker(
                alignment: Alignment.center,
                height: 35,
                width: 35,
                point: LatLng(route.lat, route.long),
                child: Icon(
                  Icons.pin_drop_rounded,
                  color: route.isCurrent ? AppColors.primary : Colors.red,
                  size: 40,
                ),
                rotate: true,
              );
            }).toList();

            // Update polylines
            polylines = [
              Polyline(
                points: state.routes.map((route) {
                  return LatLng(route.lat, route.long);
                }).toList(),
                borderStrokeWidth: 3.5,
                color: Colors.blue,
                borderColor: Colors.green,
              ),
            ];

            return FlutterMap(
              options: MapOptions(
                initialCenter: markers.isNotEmpty ? markers.first.point : const LatLng(0, 0),
                initialZoom: 4.5,
                maxZoom: 45,
                // onTap: (_, __) => _popupController.hideAllPopups(),
              ),
              children: <Widget>[
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylineCulling: true,
                  polylines: polylines,
                ),
                MarkerLayer(
                  alignment: Alignment.topCenter,
                  markers: markers,
                ),
              ],
            );
          } else if (state is RoutesError) {
            return Center(
              child: Text('Error loading routes: ${state.failure}'),
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
