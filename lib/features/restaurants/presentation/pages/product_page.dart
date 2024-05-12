import 'package:assign_1/constants.dart';
import 'package:assign_1/features/restaurants/model/grand_permission.dart';
import 'package:assign_1/features/restaurants/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../cubit/restaurant_cubit.dart';
import '../../cubit/restaurant_state.dart';
import '../../model/restaurant.dart';
import '../widgets/restaurant_widget.dart';
import 'add_restaurant.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  static String id = 'ProductPage';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RestaurantCubit>(context).getRestaurants();
    GrantPermissions.grantLocationPermission();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.sync, color: kSecondaryColor,),
            alignment: Alignment.topRight,
            onPressed: () {
              // BlocProvider.of<StoreCubit>(context).sync();
            },
          ),
        ],
        title: const Text('Store Home', style: TextStyle(color: kSecondaryColor),),
      ),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text('No Store Added'),
            );
          } else if(state is RestaurantsUpdatedState){
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                Restaurant store = state.restaurants[index];
                return ProductWidget(restaurant: store,
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
          color: kSecondaryColor,
        ),
      ),
    );
  }
}

