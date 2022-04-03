import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_cleaning_service/logic/cubit/get_location_cubit/get_location_cubit.dart';

import '../../core/exceptions/route_exception.dart';
import '../../data/models/type_user.dart';
import '../../logic/cubit/all_trains_cubit/all_trains_cubit.dart';
import '../../logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import '../../logic/cubit/login_cubit/login_cubit.dart';
import '../../logic/cubit/register_cubit/register_cubit.dart';
import '../screens/auth/landing_screen/landing_page.dart';
import '../screens/auth/login_screen/login_page.dart';
import '../screens/auth/signup_screen/signup_page.dart';
import '../screens/user/user_screen/user_page.dart';

class AppRouter {
  static const String landingPage = '/';
  static const String userPage = '/userPage';
  static const String loginPage = '/loginPage';
  static const String signInPage = '/signInPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userPage:
        TypeUser typeUser = settings.arguments as TypeUser;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AllTrainsCubit(),
              ),
              BlocProvider(
                create: (context) => GetLocationCubit(),
              ),
            ],
            child: UserPage(
              typeUser: typeUser,
            ),
          ),
        );
      case landingPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LandingScreenCubit(),
            child: const LandingPage(),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );
      case signInPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const SignInPage(),
          ),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
