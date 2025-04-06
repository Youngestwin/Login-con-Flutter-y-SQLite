// map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'marker_form_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};

  // Ubicación inicial (ejemplo: Ciudad de México)
  static const LatLng _initialPosition = LatLng(19.4326, -99.1332);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        onLongPress: _onMapLongPress, // Agregar nuevo marcador
        onTap: (_) {}, // Evitar que el InfoWindow se cierre al tocar fuera
      ),
    );
  }

  // Agregar nuevo marcador
  void _onMapLongPress(LatLng position) async {
    final markerData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerFormScreen(position: position),
      ),
    );

    if (markerData != null && markerData is Map<String, String>) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: markerData['title'],
              snippet: markerData['description'],
            ),
            onTap:
                () => _showMarkerOptions(position), // Mostrar opciones al tocar
          ),
        );
      });
    }
  }

  // Mostrar diálogo con opciones de edición/eliminación
  void _showMarkerOptions(LatLng position) {
    final marker = _markers.firstWhere((m) => m.position == position);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(marker.infoWindow.title ?? 'Marcador'),
            content: Text(marker.infoWindow.snippet ?? 'Sin descripción'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar diálogo
                  _editMarker(marker); // Editar marcador
                },
                child: const Text('Editar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _markers.remove(marker); // Eliminar marcador
                  });
                  Navigator.pop(context); // Cerrar diálogo
                },
                child: const Text('Eliminar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );
  }

  // Editar marcador existente
  void _editMarker(Marker marker) async {
    final markerData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MarkerFormScreen(
              position: marker.position,
              initialTitle: marker.infoWindow.title,
              initialDescription: marker.infoWindow.snippet,
            ),
      ),
    );

    if (markerData != null && markerData is Map<String, String>) {
      setState(() {
        _markers.remove(marker); // Eliminar el marcador viejo
        _markers.add(
          Marker(
            markerId: marker.markerId,
            position: marker.position,
            infoWindow: InfoWindow(
              title: markerData['title'],
              snippet: markerData['description'],
            ),
            onTap: () => _showMarkerOptions(marker.position),
          ),
        );
      });
    }
  }
}
