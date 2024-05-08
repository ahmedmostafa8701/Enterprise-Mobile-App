
import 'package:assign_1/stores/cubit/store_cubit.dart';
import 'package:assign_1/stores/model/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AddStore extends StatelessWidget {
  AddStore({super.key});
  static String id = 'AddStore';
  late LatLng latLng;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Store'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Store Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          /*Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(37.42796133580664, -122.085749655962),
                  visible: true,
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
              onTap: (LatLng latLng) {
                this.latLng = latLng;
              }
            ),
          ),*/
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          BlocProvider.of<StoreCubit>(context).addStore(Store(name: controller.text, location: const LatLng(0, 0)));
          Navigator.pop(context);
        },
        child: Icon(
          Icons.check,
          color: Colors.red,
        ),
      )
    );
  }
}
