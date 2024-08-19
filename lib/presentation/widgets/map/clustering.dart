import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
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
  final PopupController _popupController = PopupController();

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
                height: 30,
                width: 30,
                point: LatLng(route.lat, route.long),
                child: const Icon(Icons.pin_drop),
              );
            }).toList();

            // Update polylines
            polylines = [
              Polyline(
                points: state.routes.map((route) {
                  return LatLng(route.lat, route.long);
                }).toList(),
                borderStrokeWidth: 6.6,
                color: Colors.blue,
                borderColor: Colors.green,
              ),
            ];

            return PopupScope(
              popupController: _popupController,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter:
                      markers.isNotEmpty ? markers.first.point : const LatLng(0, 0), // Default to (0, 0) if no markers
                  initialZoom: 4.5,
                  maxZoom: 45,
                  onTap: (_, __) => _popupController.hideAllPopups(),
                ),
                children: <Widget>[
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      spiderfyCircleRadius: 80,
                      spiderfySpiralDistanceMultiplier: 2,
                      circleSpiralSwitchover: 12,
                      maxClusterRadius: 120,
                      rotate: true,
                      size: const Size(40, 40),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50),
                      maxZoom: 15,
                      markers: markers,
                      polygonOptions: const PolygonOptions(
                        borderColor: Colors.blueAccent,
                        color: Colors.black12,
                        borderStrokeWidth: 3,
                      ),
                      popupOptions: PopupOptions(
                        popupSnap: PopupSnap.markerTop,
                        popupController: _popupController,
                        popupBuilder: (_, marker) => Container(
                          width: 200,
                          height: 100,
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () => debugPrint('Popup tap!'),
                            child: const Text(
                              'Container popup for marker',
                            ),
                          ),
                        ),
                      ),
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  PolylineLayer(
                    polylineCulling: true,
                    polylines: polylines,
                  ),
                ],
              ),
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

/* class ClusteringPage extends StatefulWidget {
  static const String route = 'clusteringPage';

  const ClusteringPage({super.key});

  @override
  State<ClusteringPage> createState() => _ClusteringPageState();
}

class _ClusteringPageState extends State<ClusteringPage> {
  final PopupController _popupController = PopupController();

  late List<Marker> markers;
  late int pointIndex;
  List<LatLng> points = [
    const LatLng(37.90970, 58.39795),
    const LatLng(37.90491, 58.39742),
  ];

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        point: points[pointIndex],
        child: const Icon(Icons.pin_drop),
      ),
      const Marker(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        child: Icon(Icons.pin_drop),
      ),
      const Marker(
        alignment: Alignment.center,
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        child: Icon(Icons.pin_drop),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pointIndex++;
          if (pointIndex >= points.length) {
            pointIndex = 0;
          }
          setState(() {
            markers[0] = Marker(
              point: points[pointIndex],
              alignment: Alignment.center,
              height: 30,
              width: 30,
              child: const Icon(Icons.pin_drop),
            );
            markers = List.from(markers);
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: PopupScope(
        popupController: _popupController,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: points[0],
            initialZoom: 4.5,
            maxZoom: 45,
            onTap: (_, __) => _popupController.hideAllPopups(), // Hide popup when the map is tapped.
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                spiderfyCircleRadius: 80,
                spiderfySpiralDistanceMultiplier: 2,
                circleSpiralSwitchover: 12,
                maxClusterRadius: 120,
                rotate: true,
                size: const Size(40, 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                maxZoom: 15,
                markers: markers,
                polygonOptions: const PolygonOptions(
                  borderColor: Colors.blueAccent,
                  color: Colors.black12,
                  borderStrokeWidth: 3,
                ),
                popupOptions: PopupOptions(
                  popupSnap: PopupSnap.markerTop,
                  popupController: _popupController,
                  popupBuilder: (_, marker) => Container(
                    width: 200,
                    height: 100,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () => debugPrint('Popup tap!'),
                      child: const Text(
                        'Container popup for marker',
                      ),
                    ),
                  ),
                ),
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            PolylineLayer(
              polylineCulling: true,
              polylines: [
                Polyline(
                  points: [const LatLng(37.90970, 58.39795), const LatLng(37.90491, 58.39742)],
                  borderStrokeWidth: 6.6,
                  color: Colors.red,
                  borderColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 */