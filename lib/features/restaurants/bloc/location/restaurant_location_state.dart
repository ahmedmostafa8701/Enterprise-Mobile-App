part of 'restaurant_location_bloc.dart';

@immutable
sealed class RestaurantLocationState {}

final class RestaurantLocationInitial extends RestaurantLocationState {}

final class RestaurantLocationLoadedState extends RestaurantLocationState {

  final Set<Marker> markers;
  final CameraPosition cameraPosition;

  RestaurantLocationLoadedState({
    required this.markers,
    required this.cameraPosition,
  });

}
