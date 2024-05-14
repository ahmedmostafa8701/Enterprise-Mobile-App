import 'package:assign_1/features/restaurants/presentation/pages/Restaurants_map_view.dart';
import 'package:assign_1/features/restaurants/presentation/pages/product_page.dart';
import 'package:assign_1/firebase_options.dart';
import 'package:assign_1/screens/login_screen.dart';
import 'package:assign_1/features/register/presentation/pages/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/restaurants/cubit/restaurant_cubit.dart';
import 'features/restaurants/presentation/pages/add_restaurant.dart';
import 'features/restaurants/presentation/pages/restaurants_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Assign());
}

class Assign extends StatelessWidget {
  const Assign({super.key});

  @override
  Widget build(BuildContext context) {
/*    if(FirebaseAuth.instance.currentUser != null){
      FirebaseAuth.instance.signOut();
    }*/
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantCubit>(
          create: (context) => RestaurantCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),

        routes: {
          RestaurantMap.id: (context) =>  RestaurantMap(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          RestaurantHome.id: (context) => RestaurantHome(),
          AddRestaurant.id: (context) => const AddRestaurant(),
          ProductPage.id: (context) => const ProductPage(),
        },

        initialRoute: RestaurantMap.id,
      ),
    );
  }
}