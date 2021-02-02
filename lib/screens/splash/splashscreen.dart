import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/splash/splashcubit.dart';
import 'package:isbusiness/cubit/splash/splashstate.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          if (state is InitialState) {
            context.bloc<SplashCubit>().initial(context);
          }

          return Scaffold(
              body: Center(
                child: Padding(
                    padding: EdgeInsets.all(120),
                    child: Image.asset('assets/images/logo.png')
                ),
              )
          );
        }
    );
  }
}