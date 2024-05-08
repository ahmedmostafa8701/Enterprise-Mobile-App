import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/store_cubit.dart';
import '../../cubit/store_state.dart';
import '../widgets/store_widget.dart';
import 'add_store.dart';
class StoreHome extends StatelessWidget {
  const StoreHome({super.key});
  static String id = 'StoreHome';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StoreCubit>(context).getStores();
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Home'),
        leading: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red,),
          alignment: Alignment.topRight,
          onPressed: () {

          },
        )
      ),
      body: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          if (state is InitialState) {
            return Center(
              child: Text('No Store Added'),
            );
          } else if(state is StoresUpdatedState){
            return ListView.builder(
              itemCount: state.stores.length,
              itemBuilder: (context, index) {
                return StoreWidget(storeName: state.stores[index].name, onTap: () {},);
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
          Navigator.pushNamed(context, AddStore.id);
        },
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
      )
    );
  }
}

