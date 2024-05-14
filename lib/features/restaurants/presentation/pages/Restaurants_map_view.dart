import 'package:assign_1/features/restaurants/bloc/location/restaurant_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/restaurants_bottom_sheet.dart';

class RestaurantMap extends StatelessWidget {
  static const String id = '/restaurant_map';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantLocationBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Restaurant Map'),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              BlocBuilder<RestaurantLocationBloc, RestaurantLocationState>(
                builder: (context, state) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      // Default position
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      context
                          .read<RestaurantLocationBloc>()
                          .setController(controller);
                    },
                    markers: state is RestaurantLocationLoadedState ? state.markers : {},


                  );
                },
              ),
              DraggableScrollableSheet(
                  minChildSize: 0.1,
                  initialChildSize: 0.1,
                  maxChildSize: 0.8,
                  builder: (context, scrollController) {
                    return RestaurantBottomSheet(
                        scrollController: scrollController);
                  }),
            ],
          )),
    ); // Your Google Maps widget can be here
  }
}
