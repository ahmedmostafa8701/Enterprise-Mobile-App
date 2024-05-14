import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/restaurant.dart';
import '../../repostories/restaurants_api.dart';

import 'restaurants_state.dart';
part 'restaurants_event.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final RestaurantsApi restaurantsApi;

  RestaurantsBloc(this.restaurantsApi) : super(InitialState()) {
    on<RestaurantsEvent>((event, emit) async {
      if (event is FetchRestaurantsEvent) {
        emit(RestaurantsLoadingState());
        try {
          List<Restaurant> restaurants = await restaurantsApi.getAllRestaurants();
          print(restaurants);
          emit(RestaurantsUpdatedState(restaurants));
        } catch (e) {
          emit(RestaurantErrorState(e.toString()));
        }
      }
    });
  }
}
