import 'package:assign_1/constants.dart';
import 'package:assign_1/features/restaurants/model/product.dart';
import 'package:flutter/material.dart';

import '../../model/restaurant.dart';
class ProductWidget extends StatefulWidget {
  ProductWidget({super.key, required this.product, required this.onTap});
  Product product;
  void Function() onTap;
  @override
  State<ProductWidget> createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              widget.product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}