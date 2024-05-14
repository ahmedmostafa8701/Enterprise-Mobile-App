import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'restaurant_location_event.dart';
part 'restaurant_location_state.dart';

class RestaurantLocationBloc extends Bloc<RestaurantLocationEvent, RestaurantLocationState> {
  GoogleMapController? controller;
  RestaurantLocationBloc() : super(RestaurantLocationInitial()) {
    on<RestaurantLocationEvent>((event, emit) {
      // TODO: implement event handler
      if (event is RestaurantLocationLoadedEvent) {
        CameraPosition cameraPosition = CameraPosition(
          target: event.location,
          zoom: 5,
        );
        Set<Marker> updatedMarkers = {};

        updatedMarkers.add(Marker(
          markerId: MarkerId("currentLocation"),
          position: event.location,
        ));

        controller?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        emit(RestaurantLocationLoadedState(markers: updatedMarkers, cameraPosition: cameraPosition));
      }
    });


  } void setController(GoogleMapController controller) {
    this.controller = controller;
  }
}
