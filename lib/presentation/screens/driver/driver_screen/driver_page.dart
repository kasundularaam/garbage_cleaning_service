import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_cleaning_service/presentation/screens/driver/driver_screen/widget/driver_map.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../widgets/sign_out_window.dart';

class DriverPage extends StatefulWidget {
  final TypeUser typeUser;
  const DriverPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  TypeUser get typeUser => widget.typeUser;

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<SendLocationCubit>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SendLocationCubit>(context).sendLocation();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: BlocBuilder<SendLocationCubit, SendLocationState>(
                    builder: (context, state) {
                      if (state is SendLocationSending) {
                        return Text(
                          state.trainLocation.trainName,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        );
                      }
                      return Text(
                        "On The Way",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (sheetContext) {
                        return BlocProvider(
                          create: (context) => SignOutCubit(),
                          child: const SignOutWindow(),
                        );
                      }),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.primaryColor,
                    size: 26.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            const Expanded(
              child: DriverMap(),
            ),
          ],
        ),
      ),
    );
  }
}
