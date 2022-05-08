import 'package:flutter/material.dart';
import 'package:garbage_cleaning_service/data/models/truck_details.dart';
import 'package:garbage_cleaning_service/presentation/screens/user/search_screen/widgets/search_result_card.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<TruckDetails> trucks = [
    TruckDetails(
        titleText: "Homagama South Garbage Truck No3",
        startStation: "Homagama Nagara Sabha",
        departureTime: "05:30",
        truckNumber: "LA-0099",
        runby: "daily",
        coveringAreas: ["Pitipana", "Moragahahena", "Dolahena"])
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightElv1,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.lightElv0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 0.5.h),
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.darkElv0,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Search",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.darkElv1,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.primaryColor,
                            size: 22.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      SearchResultCard(truck: trucks[index])),
            )
          ],
        ),
      ),
    );
  }
}
