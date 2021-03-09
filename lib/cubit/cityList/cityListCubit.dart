import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/api/Api.dart';

import 'cityListState.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit(this.apiService) : super(InitialCityListState());

  ApiService apiService;

  void initial(String key) async {
    var cities;
    if (key.length == 0) cities = await apiService.getCityList("М");
    else cities = await apiService.getCityList(key);
    emit(LoadingCityListState());
    emit(LoadedCityListState(cities.cityList));
  }
}