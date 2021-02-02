import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/menu/menustate.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(InitialMenuState(0));
}