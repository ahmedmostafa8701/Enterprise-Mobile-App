part of 'restaurant_location_bloc.dart';

@immutable
sealed class RestaurantLocationEvent {}

final class RestaurantLocationInitialEvent extends RestaurantLocationEvent {}

final class RestaurantLocationLoadedEvent extends RestaurantLocationEvent {
  final LatLng location;

  RestaurantLocationLoadedEvent({
    required this.location,
  });
}
