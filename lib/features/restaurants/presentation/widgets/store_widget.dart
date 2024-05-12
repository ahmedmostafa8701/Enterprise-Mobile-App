import 'package:flutter/material.dart';

import '../../model/store.dart';
class StoreWidget extends StatefulWidget {
  StoreWidget({super.key, required this.store, required this.onTap, required this.onFavTap});
  Store store;
  void Function() onTap;
  void Function(bool status) onFavTap;
  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  Color favorite = Colors.red;

  Color notFavorite = Colors.grey;

  late Color color;
  @override
  Widget build(BuildContext context) {
    setState(() {
      color = widget.store.favFlag == 1 ? favorite : notFavorite;
    });
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  widget.store.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  onPressed: (){
                    bool status = widget.store.favFlag != 1;
                    setState(() {
                      color = color == favorite ? notFavorite : favorite;
                      widget.store.favFlag = widget.store.favFlag == 1 ? 0 : 1;
                    });
                    widget.onFavTap(status);
                  },
                  icon: const Icon(Icons.favorite),
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}