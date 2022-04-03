import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_cleaning_service/core/constants/strings.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import '../../../router/app_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LandingScreenCubit>(context).startApp();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(Strings.landingImage),
              SizedBox(
                height: 5.h,
              ),
              BlocConsumer<LandingScreenCubit, LandingScreenState>(
                listener: (context, state) {
                  if (state is LandingScreenSucceed) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.userPage,
                      (route) => false,
                      arguments: state.typeUser,
                    );
                  } else if (state is LandingScreenNoUser) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.loginPage,
                      (route) => false,
                    );
                  } else if (state is LandingScreenFailed) {
                    SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is LandingScreenFailed) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "something went wrong!",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextButton(
                          onPressed: () =>
                              BlocProvider.of<LandingScreenCubit>(context)
                                  .startApp(),
                          child: const Text(
                            "RETRY",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      "Loading...",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 10.sp,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
