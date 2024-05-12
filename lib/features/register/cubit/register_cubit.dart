import 'package:assign_1/features/register/cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterInitial());

  void registerUser(String email, String password) async {
    emit(RegisterLoading());

  }
}