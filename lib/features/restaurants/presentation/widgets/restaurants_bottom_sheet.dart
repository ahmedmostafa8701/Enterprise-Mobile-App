import 'package:assign_1/features/restaurants/bloc/location/restaurant_location_bloc.dart';
import 'package:assign_1/features/restaurants/bloc/restaurants/restaurants_bloc.dart';
import 'package:assign_1/features/restaurants/repostories/restaurants_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/restaurants/restaurants_state.dart';

class RestaurantBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  RestaurantBottomSheet({Key? key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsBloc(RestaurantsApi())..add(FetchRestaurantsEvent()),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is RestaurantsUpdatedState) {
              return ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.restaurants[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.gps_fixed),
                            onPressed: () {
                              LatLng restaurantLocation = state.restaurants[index].location;
                              BlocProvider.of<RestaurantLocationBloc>(context)
                                  .add(
                                  RestaurantLocationLoadedEvent(
                                      location: restaurantLocation));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.directions),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      onTap: () {
                        // Add functionality for the first restaurant
                      },
                    ),
                  );
                },
                controller: scrollController,
                shrinkWrap: true,
              );
            }
            if (state is RestaurantErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
            // return ListView.builder(
            //   itemCount: 10,
            //   itemBuilder: (context, index) {
            //     return Card(
            //       child: ListTile(
            //         title: Text('Restaurant ${index + 1}'),
            //         trailing: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             IconButton(
            //               icon: const Icon(Icons.gps_fixed),
            //               onPressed: () {
            //                 LatLng restaurantLocation = LatLng(32, 30);
            //                 BlocProvider.of<RestaurantLocationBloc>(context)
            //                     .add(
            //                     RestaurantLocationLoadedEvent(
            //                         location: restaurantLocation));
            //               },
            //             ),
            //             IconButton(
            //               icon: const Icon(Icons.directions),
            //               onPressed: () {},
            //             ),
            //           ],
            //         ),
            //         onTap: () {
            //           // Add functionality for the first restaurant
            //         },
            //       ),
            //     );
            //   },
            //   controller: scrollController,
            //   shrinkWrap: true,
            // );
          },
        ),
      ),
    );
  }
}
