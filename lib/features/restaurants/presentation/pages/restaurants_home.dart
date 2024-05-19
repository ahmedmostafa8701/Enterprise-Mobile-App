import 'package:assign_1/constants.dart';
import 'package:assign_1/features/restaurants/model/grand_permission.dart';
import 'package:assign_1/features/restaurants/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/restaurant_cubit.dart';
import '../../cubit/restaurant_state.dart';
import '../../model/restaurant.dart';
import '../widgets/restaurant_widget.dart';

class RestaurantHome extends StatelessWidget {
  const RestaurantHome({super.key});
  static String id = 'RestaurantHome';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RestaurantCubit>(context).getRestaurants();
    GrantPermissions.grantLocationPermission();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: kSecondaryColor,),
            alignment: Alignment.topRight,
            onPressed: () {
              BlocProvider.of<RestaurantCubit>(context).getRestaurants();
            },
          ),
        ],
        title: const Text('Restaurant Home', style: TextStyle(color: kSecondaryColor),),
      ),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text('No Restaurants Added'),
            );
          }
          else if(state is RestaurantsLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is RestaurantErrorState){
            return Center(
              child: Text(state.message),
            );
          }
          else if(state is RestaurantsUpdatedState){
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  Restaurant restaurant = state.restaurants[index];
                  return RestaurantWidget(restaurant: restaurant,
                    onTap: () async {
                      Navigator.pushNamed(context, ProductPage.id,arguments: restaurant.id);
                    },
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

