import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:garbage_cleaning_service/core/themes/app_colors.dart';
import 'package:garbage_cleaning_service/data/models/truck_details.dart';

class SearchResultCard extends StatelessWidget {
  final TruckDetails truck;
  const SearchResultCard({
    Key? key,
    required this.truck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
                color: AppColors.lightElv0,
                borderRadius: BorderRadius.circular(3.w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  truck.titleText,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "(${truck.truckNumber})",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Text(
                      "starts collecting at ${truck.departureTime}",
                      style: TextStyle(
                        color: AppColors.darkElv1,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      truck.runby,
                      style: TextStyle(
                        color: AppColors.darkElv1,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Divider(),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Covering areas",
                  style: TextStyle(
                      color: AppColors.darkElv0,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Wrap(
                  spacing: 2.w,
                  children: truck.coveringAreas
                      .map((e) => Chip(
                            label: Text(
                              e,
                              style:
                                  const TextStyle(color: AppColors.lightElv0),
                            ),
                            backgroundColor: AppColors.primaryColor,
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
