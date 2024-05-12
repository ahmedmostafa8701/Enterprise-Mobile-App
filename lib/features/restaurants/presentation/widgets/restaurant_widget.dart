import 'package:assign_1/constants.dart';
import 'package:flutter/material.dart';

import '../../model/restaurant.dart';
class RestaurantWidget extends StatefulWidget {
  RestaurantWidget({super.key, required this.restaurant, required this.onTap});
  Restaurant restaurant;
  void Function() onTap;
  @override
  State<RestaurantWidget> createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: widget.onTap,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: kSecondaryColor,
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