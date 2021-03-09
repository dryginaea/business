import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/city/city.dart';

abstract class CityListState extends Equatable {}

class InitialCityListState extends CityListState {
  @override
  List<Object> get props => [];
}

class LoadingCityListState extends CityListState {
  @override
  List<Object> get props => [];
}

class LoadedCityListState extends CityListState {
  List<City> cityList;

  LoadedCityListState(this.cityList);

  @override
  List<Object> get props => [cityList];
}