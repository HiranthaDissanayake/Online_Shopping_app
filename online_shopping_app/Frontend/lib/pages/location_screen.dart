import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Fetch current location
  void _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle location service being disabled
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle location permission being denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle location permission being permanently denied
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }
  }

  // Handle map tap to select a location
  void _onMapTapped(LatLng position) {
    if (position.latitude == 7.873054 && position.longitude == 80.771797) {
      setState(() {
        _selectedLocation = LatLng(7.873054, 80.771797);
      });
    } else {
      setState(() {
        _selectedLocation = position;
      });
    }
  }

  // Confirm the selected location
  void _onConfirmLocation() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation);
    } else {
      // Show a message if no location is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a location")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Select Your Location",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition != null
                  ? LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude)
                  : LatLng(7.8731, 80.7718), // Default to Sri Lanka
              zoom: 14,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            
            
            onTap: _onMapTapped,
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: MarkerId("selectedLocation"),
                      position: _selectedLocation!,
                    )
                  }
                : {},
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
              // Make sure to animate the camera to current position after the map is created
              if (_currentPosition != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5, right: 50),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: _onConfirmLocation,
          label: Text("Confirm Location", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          icon: Icon(Icons.check,color: Colors.white,),
        ),
      ),
    );
  }
}
