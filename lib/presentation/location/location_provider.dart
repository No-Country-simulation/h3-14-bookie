// Este código es un proveedor de ubicación que:
// 1. Importa los paquetes necesarios para manejar ubicación y mapas de Google
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider {
  // Crea una instancia de Location para acceder a la ubicación del dispositivo
  final Location _location = Location();

  // Método que obtiene la ubicación actual del usuario
  Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Verifica si el servicio de ubicación está habilitado
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      // Si no está habilitado, solicita al usuario que lo active
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null; // Si el usuario rechaza activarlo, retorna null
      }
    }

    // Verifica si la app tiene permisos de ubicación
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // Si no tiene permisos, los solicita al usuario
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null; // Si el usuario rechaza los permisos, retorna null
      }
    }

    // Obtiene los datos de ubicación actual
    final locationData = await _location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      // Retorna la ubicación como un objeto LatLng de Google Maps
      return LatLng(locationData.latitude!, locationData.longitude!);
    }

    return null; // Si no se pudo obtener la ubicación, retorna null
  }
}
