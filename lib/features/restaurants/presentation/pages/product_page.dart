import 'package:assign_1/constants.dart';
import 'package:assign_1/features/restaurants/cubit/products_cubit.dart';
import 'package:assign_1/features/restaurants/cubit/products_state.dart';
import 'package:assign_1/features/restaurants/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  static String id = 'ProductPage';

  @override
  Widget build(BuildContext context) {
    int? restaurantID = ModalRoute.of(context)?.settings.arguments as int?;
    BlocProvider.of<ProductsCubit>(context).getProducts(restaurantID!);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: kSecondaryColor,),
            alignment: Alignment.topRight,
            onPressed: () {
              BlocProvider.of<ProductsCubit>(context).getProducts(restaurantID!);
            },
          ),
        ],
        title: const Text('Store Home', style: TextStyle(color: kSecondaryColor),),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text('No Store Added'),
            );
          }
          else if(state is ProductsLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is ProductsUpdatedState){
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                Product product = state.products[index];
                return ProductWidget(product: product,
                  onTap: () async {
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

