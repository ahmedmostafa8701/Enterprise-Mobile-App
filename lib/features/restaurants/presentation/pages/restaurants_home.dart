import 'package:assign_1/features/restaurants/model/grand_permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../cubit/restaurant_cubit.dart';
import '../../cubit/restaurant_state.dart';
import '../../model/store.dart';
import '../widgets/store_widget.dart';
import 'add_restaurant.dart';

class RestaurantHome extends StatelessWidget {
  RestaurantHome({super.key});
  static String id = 'RestaurantHome';
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RestaurantCubit>(context).getRestaurants();
    GrantPermissions.grantLocationPermission();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.sync, color: Colors.red,),
            alignment: Alignment.topRight,
            onPressed: () {
              // BlocProvider.of<StoreCubit>(context).sync();
            },
          ),
        ],
        title: const Text('Store Home'),
        leading: IconButton(
          icon: Icon(Icons.favorite, color: color,),
          alignment: Alignment.topRight,
          onPressed: () {
            // BlocProvider.of<StoreCubit>(context).switchMode();
          },
        )
      ),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text('No Store Added'),
            );
          } else if(state is RestaurantsUpdatedState){
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  Store store = state.restaurants[index];
                  return StoreWidget(store: store,
                    onFavTap: (status) {
                      // BlocProvider.of<StoreCubit>(context).changeFavorite(store, status);
                    },
                    onTap: () async {
                      Position location = await Geolocator.getCurrentPosition();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${Geolocator.distanceBetween(
                                location.latitude, location.longitude,
                                store.location.latitude , store.location.longitude)}',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddRestaurant.id);
        },
        child: const Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    );
  }
}

