import 'package:assign_1/firebase_options.dart';
import 'package:assign_1/screens/login_screen.dart';
import 'package:assign_1/features/register/presentation/pages/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/stores/cubit/store_cubit.dart';
import 'features/stores/presentation/pages/add_store.dart';
import 'features/stores/presentation/pages/stores_home.dart';

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
        BlocProvider<StoreCubit>(
          create: (context) => StoreCubit(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),

        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          StoreHome.id: (context) => StoreHome(),
          AddStore.id: (context) => const AddStore(),
        },

        initialRoute: LoginScreen.id,
      ),
    );
  }
}