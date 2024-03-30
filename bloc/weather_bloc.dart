import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      print("ONE TWO");
      try {
        WeatherFactory wf = WeatherFactory(Api_Key);

        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);

        emit(WeatherSuccess(weather));
        print(weather);
      } catch (e) {
        emit(WeatherError());
        print(e.toString());
        print("E");
      }
    });
  }
}
