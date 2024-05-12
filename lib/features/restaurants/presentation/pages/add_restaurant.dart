import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../cubit/restaurant_cubit.dart';
import '../../model/store.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});
  static String id = 'AddRestaurant';

  @override
  AddRestaurantState createState() => AddRestaurantState();
}

class AddRestaurantState extends State<AddRestaurant> {
  late LatLng latLng;
  TextEditingController textController = TextEditingController();
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static Marker? currentMarker;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Restaurant Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                if(_controller.isCompleted) {
                  _controller.complete(controller);
                }
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              markers: currentMarker != null ? {currentMarker!} : {},
              onTap: (LatLng latLng) {
                currentMarker = Marker(
                  markerId: const MarkerId('1'),
                  position: latLng,
                  visible: true,
                  icon: BitmapDescriptor.defaultMarker,
                );
                setState(() {});
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          if(textController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter store name'),
              ),
            );
            return;
          }
          LatLng location = currentMarker?.position ?? initialCameraPosition.target;
          BlocProvider.of<RestaurantCubit>(context).addStore(
            Store(
              name: textController.text,
              location: location,
              id: '${Random().nextInt(10)}-${DateTime.now().millisecondsSinceEpoch.toString().replaceAll(" ", "")}',
            ),
          );
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.check,
          color: Colors.red,
        ),
      ),
    );
  }
}