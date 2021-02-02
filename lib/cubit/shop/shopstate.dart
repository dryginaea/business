import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/course/course.dart';
import 'package:isbusiness/data/product/product.dart';

abstract class ShopState extends Equatable {}

class InitialShopState extends ShopState {
  @override
  List<Object> get props => [];
}

class LoadingShopState extends ShopState {
  @override
  List<Object> get props => [];
}

class LoadedShopState extends ShopState {
  String balls;
  String avatar;
  List<Product> products;
  List<Course> courses;
  List<int> interests;
  int free;

  LoadedShopState(this.balls, this.products, this.avatar, this.courses, this.interests, this.free);

  @override
  List<Object> get props => [balls, products, avatar, courses, interests, free];
}

class ErrorShopState extends ShopState {
  @override
  List<Object> get props => [];
}