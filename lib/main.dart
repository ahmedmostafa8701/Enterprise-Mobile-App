import 'package:assign_1/screens/login_screen.dart';
import 'package:assign_1/screens/register_screen.dart';
import 'package:assign_1/stores/cubit/store_cubit.dart';
import 'package:assign_1/stores/cubit/store_state.dart';
import 'package:assign_1/stores/presentation/pages/add_store.dart';
import 'package:assign_1/stores/presentation/pages/stores_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Assign());
}

class Assign extends StatelessWidget {
  const Assign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreCubit>(
      create: (context) => StoreCubit() ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),

        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          StoreHome.id: (context) => const StoreHome(),
          AddStore.id: (context) => AddStore(),
        },

        initialRoute: StoreHome.id,
      ),
    );
  }
}
