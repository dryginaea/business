import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/login/logincubit.dart';
import 'package:isbusiness/screens/login/loginscreen.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices
];
List<SingleChildWidget> independentServices = [
  BlocProvider(
    create: (context) => LoginCubit(),
    child: LoginScreen(),
  )
];
List<SingleChildWidget> dependentServices = [];