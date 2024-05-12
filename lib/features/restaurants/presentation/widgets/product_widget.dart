import 'package:assign_1/constants.dart';
import 'package:flutter/material.dart';

import '../../model/restaurant.dart';
class ProductWidget extends StatefulWidget {
  ProductWidget({super.key, required this.restaurant, required this.onTap});
  Restaurant restaurant;
  void Function() onTap;
  @override
  State<ProductWidget> createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: kSecondaryColor,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.restaurant.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}