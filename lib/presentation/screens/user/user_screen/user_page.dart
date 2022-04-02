import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/all_trains_cubit/all_trains_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../router/app_router.dart';
import '../../widgets/sign_out_window.dart';
import 'widgets/user_map.dart';

class UserPage extends StatefulWidget {
  final TypeUser typeUser;
  const UserPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TypeUser get typeUser => widget.typeUser;
  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<AllTrainsCubit>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllTrainsCubit>(context).loadTrains();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 3.w,
                ),
                SizedBox(
                  width: 1.w,
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
                SizedBox(
                  width: 1.w,
                ),
              ],
            ),
            const Expanded(
              child: UserMap(),
            ),
          ],
        ),
      ),
    );
  }
}
